# homebrew-tap

Homebrew tap for [gitpic](https://github.com/tarnish233/gitpic-cli) —— 命令行工具和菜单栏应用
各占一个名字：

```bash
brew install tarnish233/tap/gitpic_cli         # Formula：命令行，装出来的命令是 gitpic
brew install --cask tarnish233/tap/gitpic_app  # Cask：菜单栏应用 GitPic.app
```

- `gitpic_cli` 是 Formula（预编译二进制），装出来的命令仍然是 `gitpic`
- `gitpic_app` 是 Cask（GitPic.app，仅 Apple Silicon）。两者同版本、来自同一个 GitHub Release，
  装了 App 不必再装 CLI，反之也一样；两个都装也不冲突 —— App 只跑自己 bundle 里那份 CLI，
  formula 那份只服务终端，共用的只有 `~/.config/gitpic/config.toml` 和上传历史。
- App 是本机自签名、未经 Apple 公证的构建，quarantine 没去掉就直接打不开，所以 cask 装完自己跑
  一次 `xattr -dr com.apple.quarantine`。`brew uninstall --zap --cask gitpic_app` 只清 App 自己的
  偏好、日志、缓存，**不动** 配置和上传历史 —— 那两份是和 CLI 共用的。
- formula 原名 `gitpic`，2026-08 改成 `gitpic_cli`，为的是和菜单栏应用 GitPic.app 区分开 ——
  两者同版本同源，但一个是命令行工具、一个是 App，不该共用一个名字。`formula_renames.json`
  里留着映射：旧名字仍然能装，已经装了的由 `brew update` / `brew upgrade` 迁移过去，也可以直接
  `brew migrate gitpic`（Cellar 目录从 `gitpic` 变成 `gitpic_cli`，`bin/gitpic` 这个软链、
  补全脚本都不变）。
- 迁移时若报 `Refusing to load formula tarnish233/tap/gitpic_cli from untrusted tap`，
  跑一次 `brew trust tarnish233/tap`（或 `brew trust --formula tarnish233/tap/gitpic_cli`）：
  Homebrew 的信任名单按名字记，改名后的新名字需要再确认一次。

每六小时检查一次 GitHub Release，formula 和 cask 一起更新；也可以在 Actions 页手动触发。

## 已下架

**cloudot**（Cask，最后版本 0.6.1）—— 项目已停止开发，cask 于 2026-08 从这个 tap 移除。
已经装了的话按 [仓库 README](https://github.com/tarnish233/cloudot) 顶部的步骤退出
（**先 `cloudot unadopt` 再删 `~/.cloudot`**，反过来会留下悬空软链导致配置读不到），
然后 `brew uninstall --cask cloudot`。已发布的 DMG 仍在
[Releases](https://github.com/tarnish233/cloudot/releases) 里。
