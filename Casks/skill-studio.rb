cask "skill-studio" do
  version "0.5.6"
  sha256 "be947505bf4b6c9c28b60739c92a103365f8f3fc28e7618fe541be5232bf7351"

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

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Skill Studio.app"]
  end
end
