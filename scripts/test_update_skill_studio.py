import unittest
from unittest.mock import Mock

from update_skill_studio import update_cask


class UpdateTests(unittest.TestCase):
    def setUp(self):
        self.text = ('cask "skill-studio" do\n  version "0.1.1"\n'
                     f'  sha256 "{"a" * 64}"\n  postflight_steps do\n'
                     '    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Skill Studio.app"]\n'
                     '  end\nend\n')
        self.release = {
            "tag_name": "v0.1.2", "draft": False, "prerelease": False,
            "assets": [{"name": "Skill.Studio_0.1.2_universal.dmg", "state": "uploaded", "size": 100,
                        "browser_download_url": "https://github.com/tarnish233/skill-studio/releases/download/v0.1.2/Skill.Studio_0.1.2_universal.dmg",
                        "digest": f'sha256:{"b" * 64}'}],
        }
        self.download = Mock(return_value="b" * 64)

    def test_update_preserves_install_steps(self):
        result = update_cask(self.text, self.release, self.download)
        self.assertEqual(result, self.text.replace('version "0.1.1"', 'version "0.1.2"').replace("a" * 64, "b" * 64))
        self.download.assert_called_once()

    def test_same_or_older_release_is_noop_without_download(self):
        for tag in ["v0.1.1", "v0.1.0"]:
            self.release["tag_name"] = tag
            self.assertEqual(update_cask(self.text, self.release, self.download), self.text)
        self.download.assert_not_called()

    def test_numeric_version_comparison(self):
        text = self.text.replace('version "0.1.1"', 'version "0.1.10"')
        self.assertEqual(update_cask(text, self.release, self.download), text)
        self.download.assert_not_called()

    def test_draft_and_prerelease_are_ignored(self):
        for flag in ["draft", "prerelease"]:
            with self.subTest(flag=flag):
                self.assertEqual(update_cask(self.text, {**self.release, flag: True}, self.download), self.text)
        self.download.assert_not_called()

    def test_missing_or_incomplete_asset_is_rejected(self):
        for assets in [[], [{**self.release["assets"][0], "state": "new"}]]:
            with self.assertRaises(ValueError):
                update_cask(self.text, {**self.release, "assets": assets}, self.download)
        self.download.assert_not_called()

    def test_checksum_mismatch_is_rejected(self):
        self.download.return_value = "c" * 64
        with self.assertRaises(ValueError):
            update_cask(self.text, self.release, self.download)

    def test_unexpected_url_is_rejected(self):
        self.release["assets"][0]["browser_download_url"] = "https://example.com/app.dmg"
        with self.assertRaises(ValueError):
            update_cask(self.text, self.release, self.download)
        self.download.assert_not_called()


if __name__ == "__main__":
    unittest.main()
