cask "skill-studio" do
  version "0.1.1"
  sha256 "3f07fea1b01c329fb8f59cc7d34ca2138c76fd5b5333dc72ffd6d711e1abd0f1"

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
end
