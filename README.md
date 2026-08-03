# homebrew-tap

Homebrew tap for [gitpic](https://github.com/tarnish233/gitpic-cli) and
[cloudot](https://github.com/tarnish233/cloudot).

```bash
brew install tarnish233/tap/gitpic
brew install --cask tarnish233/tap/cloudot
```

- `gitpic` 是 Formula（预编译二进制）
- `cloudot` 是 Cask（菜单栏 GUI + 内嵌 CLI）；装完需要
  `xattr -dr com.apple.quarantine /Applications/Cloudot.app`

两者都会每六小时检查一次 GitHub Release，也可以在 Actions 页手动触发。
