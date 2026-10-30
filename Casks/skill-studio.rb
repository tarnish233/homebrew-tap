cask "skill-studio" do
  version "0.6.13"
  sha256 "f0343c9d2d38e8a6980f699e1f1e83d8a6a6f12538d2a3c9f2e1138a1648c3c0"

  url "https://github.com/tarnish233/skill-studio/releases/download/v#{version}/Skill.Studio_#{version}_universal.dmg"
  name "Skill Studio"
  desc "Manage agent skills for Claude Code, Codex, and projects"
  homepage "https://github.com/tarnish233/skill-studio"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Skill Studio.app"
  binary "#{appdir}/Skill Studio.app/Contents/MacOS/skill-studio-cli", target: "skill-studio"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Skill Studio.app"]
  end
end
