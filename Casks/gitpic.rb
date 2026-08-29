cask "gitpic" do
  version "0.20.9"
  sha256 "9d2b9b5cfe8ebe3c24ef0ea24856e3029a022b705bf39630a81915dc2733794e"

  url "https://github.com/tarnish233/gitpic/releases/download/v#{version}/GitPic-#{version}-macos-arm64.dmg"
  name "GitPic"
  desc "Menu-bar app that uploads images to a GitHub repository and copies the link"
  homepage "https://github.com/tarnish233/gitpic"

  # **This stanza governs bare `brew upgrade`, and not `brew upgrade --cask gitpic`.** The
  # distinction was missing here and the comment claimed the wrong one, so it is worth stating
  # from Homebrew's own source rather than from the documentation.
  #
  # Bare `brew upgrade` (and `brew outdated`) is where it does what it says. `Cask#outdated_version`
  # reaches `if auto_updates && !greedy && !greedy_auto_updates` (cask.rb:435), and for an
  # `auto_updates` cask reads the version out of the installed `GitPic.app/Contents/Info.plist`
  # and compares *that* against the version above (`auto_updates_bundle_outdated?`, cask.rb:806)
  # instead of trusting its own install receipt. That is the useful half: a receipt goes stale the
  # moment the app updates itself, and without this stanza brew would reinstall a version already
  # on disk. `HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS` turns it off; the opposite variable is now
  # the default and `odeprecated`.
  #
  # **Naming the cask bypasses all of that.** `Cask::Upgrade` splits on whether any cask was
  # named: with none it passes the user's greedy flags, and with one it calls
  # `cask.outdated?(greedy: true)` unconditionally (upgrade.rb:70). `greedy: true` makes
  # cask.rb:435 false, so the `auto_updates` branch is skipped entirely and the answer falls
  # through to plain receipt inequality (cask.rb:433, :443). So for the one command a user is
  # ever told to type, this stanza decides nothing.
  #
  # That is why the app cannot lean on it and does its own comparison against the tap before
  # offering the command. The stanza is kept for now because the currently released app installs
  # its own updates over a cask-managed bundle; it comes out once the version that defers to brew
  # has shipped, after which plain receipt comparison is the correct behaviour and this would be
  # a false assertion about a bundle that no longer updates itself.
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
  # Linux and Intel, which this zip does not cover.
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
