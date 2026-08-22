# homebrew-tap

Homebrew tap for [gitpic](https://github.com/tarnish233/gitpic-cli)。装一个就够，看你要哪一半：

```bash
brew install --cask tarnish233/tap/gitpic_app  # Cask：GitPic.app + 终端命令 gitpic
brew install tarnish233/tap/gitpic_cli         # Formula：只要命令行（Linux / Intel / 服务器）
```

- `gitpic_app` 内嵌的就是同版本的 CLI，所以 cask 会把它软链成 `bin/gitpic` 并生成 bash、zsh、fish
  三份补全 —— App 和终端命令是同一个二进制，升 App 就是升命令，版本不可能对不上。
- `gitpic_cli` 是纯命令行（预编译二进制 + 补全）。App 只有 arm64 包，Linux、Intel Mac、CI 走它。
- **两个别都装**，它们抢同一个 `bin/gitpic` 和同三份补全。两个方向都实测过：
  - cask 先在 → `brew install gitpic_cli` 以 `Error: The \`brew link\` step did not complete
    successfully` 结束：keg 装上了但整个没 link（`brew doctor` 会念它），命令和补全仍归 cask。
  - formula 先在 → cask 照样装完 App，只是打印 `skipping link` 和三条 `Will not overwrite …`；
    命令和补全仍归 formula，且 keg 里的文件一个字节没动（md5 比对过 —— brew 自己拦住了写穿软链）。
  两种情况都能用，只是 App 里那份 CLI 白放着。要切换先卸掉另一个；**从「formula 先在」切到 cask
  之后要补一次 `brew reinstall --cask gitpic_app`** —— 当初 cask 跳过了链接，卸掉 formula 之后
  `bin/gitpic` 会直接消失。
- App 是本机自签名、未经 Apple 公证的构建，quarantine 不去掉根本打不开，所以 cask 在 `preflight` 里
  先 `xattr -dr com.apple.quarantine`（必须在这一步：补全是**跑**那个二进制生成的，带着 quarantine
  会被 macOS SIGKILL）。`brew uninstall --cask gitpic_app` 会把软链和三份补全一并清掉；`--zap` 再清
  App 自己的偏好、日志、缓存，**不动** `~/.config/gitpic` 和上传历史 —— 那两份是和 CLI 共用的。
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
