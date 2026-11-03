cask "skill-studio" do
  version "0.6.19"
  sha256 "a8f39f92bca456f1b2f82094b2d8523717607cafd6d4a07ea3cfb0c56b1789aa"

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
