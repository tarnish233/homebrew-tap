# homebrew-tap

Homebrew tap for [gitpic](https://github.com/tarnish233/gitpic-cli).

```bash
brew install tarnish233/tap/gitpic_cli
```

- `gitpic_cli` 是 Formula（预编译二进制），装出来的命令仍然是 `gitpic`
- formula 原名 `gitpic`，2026-08 改成 `gitpic_cli`，为的是和菜单栏应用 GitPic.app 区分开 ——
  两者同版本同源，但一个是命令行工具、一个是 App，不该共用一个名字。`formula_renames.json`
  里留着映射：旧名字仍然能装，已经装了的由 `brew update` / `brew upgrade` 迁移过去，也可以直接
  `brew migrate gitpic`（Cellar 目录从 `gitpic` 变成 `gitpic_cli`，`bin/gitpic` 这个软链、
  补全脚本都不变）。
- 迁移时若报 `Refusing to load formula tarnish233/tap/gitpic_cli from untrusted tap`，
  跑一次 `brew trust tarnish233/tap`（或 `brew trust --formula tarnish233/tap/gitpic_cli`）：
  Homebrew 的信任名单按名字记，改名后的新名字需要再确认一次。

每六小时检查一次 GitHub Release，也可以在 Actions 页手动触发。

## 已下架

**cloudot**（Cask，最后版本 0.6.1）—— 项目已停止开发，cask 于 2026-08 从这个 tap 移除。
已经装了的话按 [仓库 README](https://github.com/tarnish233/cloudot) 顶部的步骤退出
（**先 `cloudot unadopt` 再删 `~/.cloudot`**，反过来会留下悬空软链导致配置读不到），
然后 `brew uninstall --cask cloudot`。已发布的 DMG 仍在
[Releases](https://github.com/tarnish233/cloudot/releases) 里。
