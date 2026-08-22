# homebrew-tap

Homebrew tap for [gitpic](https://github.com/tarnish233/gitpic)。装一个就够，看你要哪一半：

```bash
brew install tarnish233/tap/gitpic          # Cask：GitPic.app + 终端命令 gitpic
brew install tarnish233/tap/gitpic_cli      # Formula：只要命令行（Linux / Intel / 服务器）
```

- `gitpic` 是 Cask（GitPic.app，仅 Apple Silicon）。它内嵌的就是同版本的 CLI，所以 cask 会把那份
  软链成 `bin/gitpic` 并生成 bash、zsh、fish 三份补全 —— App 和终端命令是同一个二进制，升 App 就是
  升命令，版本不可能对不上。裸名字不用加 `--cask`：这个 tap 里 `gitpic` 只有 cask 一个。
- `gitpic_cli` 是 Formula（预编译二进制 + 补全），装出来的命令同样是 `gitpic`。App 只有 arm64 包，
  Linux、Intel Mac、CI 走它。
- **两个别都装**，它们抢同一个 `bin/gitpic` 和同三份补全。两个方向都实测过：
  - cask 先在 → `brew install gitpic_cli` 以 `Error: The \`brew link\` step did not complete
    successfully` 结束：keg 装上了但整个没 link（`brew doctor` 会念它），命令和补全仍归 cask。
  - formula 先在 → cask 照样装完 App，只是打印 `skipping link` 和三条 `Will not overwrite …`；
    命令和补全仍归 formula，且 keg 里的文件一个字节没动（md5 比对过 —— brew 自己拦住了写穿软链）。
  两种情况都能用，只是 App 里那份 CLI 白放着。要切换先卸掉另一个；**从「formula 先在」切到 cask
  之后要补一次 `brew reinstall --cask gitpic`** —— 当初 cask 跳过了链接，卸掉 formula 之后
  `bin/gitpic` 会直接消失。
- App 是本机自签名、未经 Apple 公证的构建，quarantine 不去掉根本打不开，所以 cask 在 `preflight` 里
  先 `xattr -dr com.apple.quarantine`（必须在这一步：补全是**跑**那个二进制生成的，带着 quarantine
  会被 macOS SIGKILL）。`brew uninstall --cask gitpic` 会把软链和三份补全一并清掉；`--zap` 再清
  App 自己的偏好、日志、缓存，**不动** `~/.config/gitpic` 和上传历史 —— 那两份是和 CLI 共用的。

## 改过的名字

| 现在 | 曾经 | 迁移 |
|---|---|---|
| Cask `gitpic` | `gitpic_app`（2026-08） | `cask_renames.json`，已装的 `brew update` 时自动迁移 |
| Formula `gitpic_cli` | `gitpic`（2026-08） | 映射**已移除** —— `gitpic` 这个名字现在归 cask |

上游仓库也从 `gitpic-cli` 改成了 [`gitpic`](https://github.com/tarnish233/gitpic)（纯 Swift 的老
App 在 [`GitPic-legacy`](https://github.com/tarnish233/GitPic-legacy)，已封存）。GitHub 会重定向旧
URL，但 formula 和 cask 里的地址都已经换成新的，不靠重定向。

`gitpic` 曾经指 formula，现在指 cask —— 所以 `brew install tarnish233/tap/gitpic` 的含义变了：以前
装的是命令行，现在装的是 App（而 App 本来就带命令行）。如果你机器上还留着改名前那个叫 `gitpic` 的
keg，先 `brew uninstall gitpic` 再按上面重装，别指望旧名映射了。

每六小时检查一次 GitHub Release，formula 和 cask 一起更新；也可以在 Actions 页手动触发。

## 已下架

**cloudot**（Cask，最后版本 0.6.1）—— 项目已停止开发，cask 于 2026-08 从这个 tap 移除。
已经装了的话按 [仓库 README](https://github.com/tarnish233/cloudot) 顶部的步骤退出
（**先 `cloudot unadopt` 再删 `~/.cloudot`**，反过来会留下悬空软链导致配置读不到），
然后 `brew uninstall --cask cloudot`。已发布的 DMG 仍在
[Releases](https://github.com/tarnish233/cloudot/releases) 里。
