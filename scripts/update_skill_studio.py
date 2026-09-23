"""Update the Cask only after a stable universal DMG is available and verified."""

import hashlib
import json
import re
import subprocess
from pathlib import Path
from urllib.request import urlopen

REPOSITORY = "tarnish233/skill-studio"
VERSION = re.compile(r"[0-9]+\.[0-9]+\.[0-9]+")


def update_cask(text, release, download_hash):
    if release.get("draft") or release.get("prerelease"):
        return text
    tag = release["tag_name"]
    version = tag.removeprefix("v")
    if tag != f"v{version}" or not VERSION.fullmatch(version):
        raise ValueError(f"Unsupported release tag: {tag}")
    versions = re.findall(r'^  version "([^"]+)"$', text, re.MULTILINE)
    if len(versions) != 1 or not VERSION.fullmatch(versions[0]):
        raise ValueError("Expected one numeric Cask version")
    if tuple(map(int, version.split("."))) <= tuple(map(int, versions[0].split("."))):
        return text
    name = f"Skill.Studio_{version}_universal.dmg"
    assets = release["assets"]
    # The release detail response can lag behind the assets endpoint just after publication.
    if not assets and release.get("id"):
        assets = json.loads(subprocess.check_output(
            ["gh", "api", f"repos/{REPOSITORY}/releases/{release['id']}/assets"], text=True
        ))
    assets = [asset for asset in assets if asset["name"] == name]
    if len(assets) != 1 or assets[0].get("state") != "uploaded" or assets[0].get("size", 0) <= 0:
        raise ValueError(f"Release DMG is not ready: {name}")
    asset = assets[0]
    url = f"https://github.com/{REPOSITORY}/releases/download/{tag}/{name}"
    if asset["browser_download_url"] != url:
        raise ValueError("Unexpected release asset URL")
    digest = download_hash(url)
    if not re.fullmatch(r"[a-f0-9]{64}", digest):
        raise ValueError("Invalid downloaded SHA-256")
    if asset.get("digest") and asset["digest"] != f"sha256:{digest}":
        raise ValueError("Downloaded DMG does not match GitHub's digest")
    text, count = re.subn(r'^  sha256 "[a-f0-9]{64}"$', f'  sha256 "{digest}"', text, flags=re.MULTILINE)
    if count != 1:
        raise ValueError("Expected one Cask SHA-256")
    return re.sub(r'^  version "[^"]+"$', f'  version "{version}"', text, flags=re.MULTILINE)


def download_hash(url):
    digest = hashlib.sha256()
    with urlopen(url, timeout=60) as response:
        for chunk in iter(lambda: response.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def main():
    release = json.loads(subprocess.check_output(
        ["gh", "api", f"repos/{REPOSITORY}/releases/latest"], text=True
    ))
    path = Path(__file__).resolve().parents[1] / "Casks/skill-studio.rb"
    previous = path.read_text()
    updated = update_cask(previous, release, download_hash)
    if updated == previous:
        print("Cask is already current; no commit needed.")
        return
    path.write_text(updated)
    print(f"Updated Cask to {release['tag_name']}")


if __name__ == "__main__":
    main()
