cask "skill-studio" do
  version "0.6.11"
  sha256 "3df82649cc2c01d9ea526bd5d3419eb9dcac5fb6d5f2623739d113e025618fa4"

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
