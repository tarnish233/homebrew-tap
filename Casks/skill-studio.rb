cask "skill-studio" do
  version "0.6.18"
  sha256 "69ec3a91c588a4a7192520a5d9b98476cdeeaaafc0c2cd4e788e6ed7436bc76b"

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
