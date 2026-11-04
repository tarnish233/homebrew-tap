cask "skill-studio" do
  version "0.6.20"
  sha256 "2a9f4f27e2d4f511475bfb129f484df06cedbc0f9b043febb48f78b70e294ff5"

  url "https://github.com/tarnish233/skill-studio/releases/download/v#{version}/Skill.Studio_#{version}_aarch64.dmg"
  name "Skill Studio"
  desc "Manage agent skills for Claude Code, Codex, and projects"
  homepage "https://github.com/tarnish233/skill-studio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Skill Studio.app"
  binary "#{appdir}/Skill Studio.app/Contents/MacOS/skill-studio-cli", target: "skill-studio"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Skill Studio.app"]
  end
end
