cask "gitpic" do
  version "0.20.10"
  sha256 "825b8062dad2eaa57f07706dd6b64d4ef9626738d3a23aed812654d5f5fc7a73"

  url "https://github.com/tarnish233/gitpic/releases/download/v#{version}/GitPic-#{version}-macos-arm64.dmg"
  name "GitPic"
  desc "Menu-bar app that uploads images to a GitHub repository and copies the link"
  homepage "https://github.com/tarnish233/gitpic"

  # A cask-managed GitPic no longer self-updates: the app compares the tap with the installed
  # bundle and hands the user `brew upgrade --cask gitpic`. Do not add `auto_updates true` — it
  # would falsely describe the artifact, and a named-cask upgrade bypasses that stanza anyway.
  # Apple Silicon only (the Release ships one arm64 disk image), and the bundle's
  # LSMinimumSystemVersion is 14.0.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "GitPic.app"
  # The app carries the CLI it drives, so the cask hands that same binary to the
  # terminal rather than asking for `gitpic_cli` beside it: one download, one copy, and
  # the two can no longer be at different versions — upgrading the app upgrades the
  # command. `gitpic_cli` stays for people who want only the command line, and for
  # Linux and Intel, which this disk image does not cover.
  #
  # Running the CLI through this symlink is the same as running it in place — but that is now an
  # invariant the CLI actively preserves rather than one it gets for free. It used to be true
  # because nothing in the CLI looked at its own location at all; `gitpic update` now does, to
  # decide which single upgrade command to print. It calls `current_exe()` and then
  # **canonicalises**, which is what keeps the two invocations equivalent: on Apple platforms
  # `current_exe()` is `_NSGetExecutablePath` with no resolution, so through this link it reports
  # the link's own path — measured, `/opt/homebrew/bin/gitpic`, which has no `.app` ancestor and
  # no Cellar above it. Without the canonicalise step the commonest install of all would be
  # classified as neither an app nor a formula and told to run the wrong command, or none.
  #
  # And if `gitpic_cli` already owns HOMEBREW_PREFIX/bin/gitpic, Homebrew sees the target belongs
  # to a formula, warns and skips the link instead of fighting over it
  # (`cask/artifact/symlinked.rb`) — the app still installs.
  binary "#{appdir}/GitPic.app/Contents/Resources/gitpic"
  # The same three completions the formula installs, generated from the binary that just
  # landed. Homebrew deletes them on uninstall, which a hand-written postflight could
  # not promise. `shells:` is spelled out because the stanza also offers :pwsh, and this
  # CLI's `completion` does not take that spelling.
  generate_completions_from_executable "#{appdir}/GitPic.app/Contents/Resources/gitpic",
                                       "completion", shells: [:bash, :zsh, :fish]

  # The bundle in the disk image is ad-hoc signed on the build machine and not notarised by
  # Apple, so a quarantined copy does not merely warn — it refuses to open at all. This is the
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
