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
  # The app carries the CLI it drives, so the cask hands that same binary to the
  # terminal rather than asking for `gitpic_cli` beside it: one download, one copy, and
  # the two can no longer be at different versions — upgrading the app upgrades the
  # command. `gitpic_cli` stays for people who want only the command line, and for
  # Linux and Intel, which this zip does not cover. Nothing in the CLI resolves paths
  # from its own location (no `current_exe`), so running it through this symlink is the
  # same as running it in place. And if `gitpic_cli` already owns
  # HOMEBREW_PREFIX/bin/gitpic, Homebrew sees the target belongs to a formula, warns and
  # skips the link instead of fighting over it (`cask/artifact/symlinked.rb`) — the app
  # still installs.
  binary "#{appdir}/GitPic.app/Contents/Resources/gitpic"
  # The same three completions the formula installs, generated from the binary that just
  # landed. Homebrew deletes them on uninstall, which a hand-written postflight could
  # not promise. `shells:` is spelled out because the stanza also offers :pwsh, and this
  # CLI's `completion` does not take that spelling.
  generate_completions_from_executable "#{appdir}/GitPic.app/Contents/Resources/gitpic",
                                       "completion", shells: [:bash, :zsh, :fish]

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
