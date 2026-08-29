cask "gitpic" do
  version "0.20.10"
  sha256 "825b8062dad2eaa57f07706dd6b64d4ef9626738d3a23aed812654d5f5fc7a73"

  url "https://github.com/tarnish233/gitpic/releases/download/v#{version}/GitPic-#{version}-macos-arm64.dmg"
  name "GitPic"
  desc "Menu-bar app that uploads images to a GitHub repository and copies the link"
  homepage "https://github.com/tarnish233/gitpic"

  # GitPic installs its own updates: 「检查更新」 in the app downloads the release's disk
  # image, verifies it against the SHA-256 GitHub publishes, and swaps the bundle. That is
  # exactly what this stanza is for, and it is what lets the app replace a cask-managed
  # bundle without brew fighting it.
  #
  # It does not mean brew stops managing gitpic. For an `auto_updates` cask Homebrew reads the
  # version out of the installed `GitPic.app/Contents/Info.plist` and compares *that* against
  # the version here (`Cask#auto_updates_bundle_outdated?`), rather than its own install
  # receipt — so `brew upgrade` still upgrades a bundle that is genuinely behind, and does
  # nothing once the app has already moved itself on. Without this stanza brew compares the
  # receipt, which goes stale the moment the app self-updates, and reinstalls a version that
  # is already on disk.
  auto_updates true
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
  # `xattr -dr com.apple.quarantine` line the README used to ask people to type.
  #
  # It has to happen here, in the staging directory, and not in `postflight`, which is
  # the obvious place and is too late: `generate_completions_from_executable` *runs* the
  # binary, and macOS SIGKILLs an ad-hoc-signed executable that is still quarantined.
  # Measured on a fresh install with the strip in postflight — "terminated by uncaught
  # signal KILL", and no completions written. `app` moves the bundle with `mv`, so the
  # cleared flag carries over to /Applications.
  preflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{staged_path}/GitPic.app"]
  end

  # Quit the app before the bundle is replaced, and let brew reopen it afterwards —
  # `Cask::Upgrade` passes `quit: true` by default and re-registers the new bundle with Launch
  # Services before `open`ing it. Without this, `brew upgrade --cask gitpic` typed into a
  # terminal moves a bundle that is still running, and the surviving process is then serving a
  # menu-bar icon from an executable, resources and embedded CLI that need not agree.
  #
  # It does not double up with the app's own updater: `uninstall quit:` skips a bundle id that
  # is not running, and the in-app path has already exited by the time anything brew-side could
  # run. GitPic is `.accessory`, so this is also the only thing that puts the menu-bar icon
  # back after a terminal upgrade.
  uninstall quit: "dev.gitpic.app"

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
