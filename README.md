# homebrew-tap

**这个 tap 已退役，不再提供任何 formula 或 cask。**

`gitpic` 的 cask 与 `gitpic_cli` 的 formula 都已于 2026-09 移除，随之下线的还有每六小时同步
Release 的 `update-gitpic.yml`。原因是上游 [gitpic](https://github.com/tarnish233/gitpic) 从
0.21.0 起只保留一条分发路径：下载 DMG 安装，之后由 app 自己更新。维护 Homebrew 这一条并行路径要
求 app 判断「这个 bundle 是不是 brew 装的」并在是的时候拒绝自更新，那套判断的成本超过了它买到的
东西。

已经 tap 过的话，清掉即可：

```bash
brew uninstall --cask gitpic      # 如果装的是 App（会同时删掉 /Applications/GitPic.app）
brew uninstall gitpic_cli         # 如果装的是命令行
brew untap tarnish233/homebrew-tap
```

⚠️ `brew uninstall --cask gitpic` **会删掉 `/Applications/GitPic.app`**，所以想继续用 App 的话
先把 DMG 下好再执行。

## 之后从哪里拿

- **App**：从 [Releases](https://github.com/tarnish233/gitpic/releases) 下
  `GitPic-<版本>-macos-arm64.dmg`，拖进 Applications，然后**必须**解除隔离，否则打不开
  —— 这一步以前是 cask 的 `preflight` 悄悄替你做的：

  ```bash
  xattr -dr com.apple.quarantine /Applications/GitPic.app
  ```

  之后的更新走 app 内的「检查更新」，它自己核对 SHA-256 并处理隔离属性。

- **终端命令 `gitpic`**：装了 App 的话，设置 ▸ 通用 ▸ 命令行 ▸「安装命令行工具」会把 App 内嵌的那份
  软链到 `~/.local/bin/gitpic` 并装好 bash、zsh、fish 三份补全 —— 和 cask 当年一样是软链而非复制，
  所以升 App 就是升命令。不装 App（Linux / Intel / CI）就从 Releases 下对应平台的压缩包，或者
  `cargo install --git https://github.com/tarnish233/gitpic`。

退役前最后发布的版本是 0.20.12（cask 与 formula 都是）。两个文件的完整内容仍在本仓库的 git 历史里，
`git log -- Casks/gitpic.rb Formula/gitpic_cli.rb` 可以取回。

## 已下架

**cloudot**（Cask，最后版本 0.6.1）—— 项目已停止开发，cask 于 2026-08 从这个 tap 移除。
已经装了的话按 [仓库 README](https://github.com/tarnish233/cloudot) 顶部的步骤退出
（**先 `cloudot unadopt` 再删 `~/.cloudot`**，反过来会留下悬空软链导致配置读不到），
然后 `brew uninstall --cask cloudot`。已发布的 DMG 仍在
[Releases](https://github.com/tarnish233/cloudot/releases) 里。
