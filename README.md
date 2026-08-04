# homebrew-tap

Homebrew tap for [gitpic](https://github.com/tarnish233/gitpic-cli).

```bash
brew install tarnish233/tap/gitpic
```

- `gitpic` 是 Formula（预编译二进制）

每六小时检查一次 GitHub Release，也可以在 Actions 页手动触发。

## 已下架

**cloudot**（Cask，最后版本 0.6.1）—— 项目已停止开发，cask 于 2026-08 从这个 tap 移除。
已经装了的话按 [仓库 README](https://github.com/tarnish233/cloudot) 顶部的步骤退出
（**先 `cloudot unadopt` 再删 `~/.cloudot`**，反过来会留下悬空软链导致配置读不到），
然后 `brew uninstall --cask cloudot`。已发布的 DMG 仍在
[Releases](https://github.com/tarnish233/cloudot/releases) 里。
