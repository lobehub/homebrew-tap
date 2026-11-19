# 🍺 LobeHub Homebrew Tap

LobeHub 官方 Homebrew tap —— 一条命令装好 LobeHub Desktop 和 `lh` CLI。

## 安装

```bash
# LobeHub 桌面端（正式版）
brew install --cask lobehub/tap/lobehub

# LobeHub CLI（lh / lobe / lobehub）
brew install lobehub/tap/lobehub-cli
```

也可以先加 tap 再装：

```bash
brew tap lobehub/tap
brew install --cask lobehub
brew install lobehub-cli
```

## 升级 / 卸载

```bash
brew upgrade --cask lobehub
brew upgrade lobehub-cli

brew uninstall --cask lobehub        # 只删 App
brew uninstall --zap --cask lobehub  # 连缓存、偏好设置、日志一起清掉
```

桌面端内置 Sparkle 自更新，日常迭代会自动升级；`brew upgrade` 用于把 brew 记录的版本对齐到最新发布。

## 两个通道

| Cask | 版本来源 | 架构 | 说明 |
| --- | --- | --- | --- |
| `lobehub` | GitHub Release 正式版（`releases/latest`） | arm64 + x64 | 推荐日常使用，Apple 公证，macOS 13+ |
| `lobehub@canary` | 最新 `*-canary.*` prerelease | 仅 arm64 | 尝鲜通道，和正式版互斥（`conflicts_with`） |

```bash
brew install --cask lobehub/tap/lobehub@canary
```

Canary 构建的上游只发布 arm64 dmg，因此该 cask 目前不覆盖 Intel。

## 这里面有什么

| 文件 | 内容 |
| --- | --- |
| `Casks/lobehub.rb` | LobeHub Desktop 正式版（Apple 公证，`LobeHub.app`，macOS 13+，arm64 / x64 双架构） |
| `Casks/lobehub@canary.rb` | LobeHub Desktop canary 通道（arm64） |
| `Formula/lobehub-cli.rb` | `@lobehub/cli`，提供 `lh` / `lobe` / `lobehub`，依赖 `node` |
| `scripts/bump.sh` | 拉 upstream 最新版本 + 重算 SHA-256 并改写上述文件 |
| `.github/workflows/bump.yml` | 每 6 小时自动 bump，有变更直接提交 |
| `.github/workflows/ci.yml` | `brew style` + `brew audit` + 校验 dmg SHA-256 |

## 版本来源

- 桌面端正式版：`lobehub/lobehub` 的 `releases/latest`，产物命名固定为 `LobeHub-<version>-arm64.dmg` / `LobeHub-<version>-x64.dmg`
- 桌面端 canary：`lobehub/lobehub` 最新带 `canary` 的 prerelease，产物为 `LobeHub-<version>-arm64.dmg`
- CLI：npm `@lobehub/cli` 的 `latest` dist-tag

## 维护说明

手动 bump：

```bash
./scripts/bump.sh            # 全量
./scripts/bump.sh stable     # 只更新正式版
./scripts/bump.sh canary     # 只更新 canary
./scripts/bump.sh formula    # 只更新 CLI
```

`bump.yml` 支持三种触发：

1. 定时（每 6 小时，cron `17 */6 * * *`），全量检查
2. 手动 `workflow_dispatch`，可选 `all / stable / canary / formula`
3. `repository_dispatch` —— `lobehub/lobehub` 的 `release-desktop-stable` / `release-desktop-canary` 在 Release 发布成功后会自动 ping 这个 tap（`event_type=desktop-release`，payload 带 `channel` 和 `version`），只 bump 对应通道；定时任务作为兜底

手动 ping：

```bash
gh api /repos/lobehub/homebrew-tap/dispatches \
  -f event_type=desktop-release \
  -f client_payload.channel=stable \
  -f client_payload.version=2.3.4
```

## 本地验证

```bash
brew tap lobehub/tap "$PWD"
brew trust lobehub/tap
brew audit --cask --online lobehub/tap/lobehub lobehub/tap/lobehub@canary
brew audit --formula --online lobehub/tap/lobehub-cli
brew fetch --cask lobehub/tap/lobehub   # 校验 dmg SHA-256
brew install --cask lobehub
```

## License

MIT
