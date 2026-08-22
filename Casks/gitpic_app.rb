cask "gitpic_app" do
  version "0.11.3"
  sha256 "6dcb414cd7cb318af7b70c328d9cf1bfd4db88633866e979b3095ef2b5bf8952"

  url "https://github.com/tarnish233/gitpic-cli/releases/download/v#{version}/GitPic-#{version}-macos-arm64.zip"
  name "GitPic"
  desc "Menu-bar app that uploads images to a GitHub repository and copies the link"
  homepage "https://github.com/tarnish233/gitpic-cli"

  # Apple Silicon only (the Release ships one arm64 zip), and the bundle's
  # LSMinimumSystemVersion is 14.0.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "GitPic.app"

  # The zip is ad-hoc signed on the build machine and not notarised by Apple, so a
  # quarantined copy does not merely warn — it refuses to open at all. This is the
  # `xattr -dr com.apple.quarantine` line the README used to ask people to type,
  # moved to the one place that knows the app just landed.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/GitPic.app"]
  end

  # Only what the app itself creates. `~/.config/gitpic/config.toml` and
  # `~/.local/share/gitpic/history.jsonl` are deliberately absent: they belong to the
  # CLI as much as to the app, and zapping the app must not empty the terminal.
  zap trash: [
    "~/Library/Caches/dev.gitpic.app",
    "~/Library/HTTPStorages/dev.gitpic.app",
    "~/Library/Logs/GitPic.log",
    "~/Library/Preferences/dev.gitpic.app.plist",
    "~/Library/Saved Application State/dev.gitpic.app.savedState",
  ]
end
