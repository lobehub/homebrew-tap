# LobeHub Homebrew Tap

Official Homebrew tap for [LobeHub](https://lobehub.com/) desktop apps.

## Install

```bash
brew tap lobehub/tap
brew install --cask lobehub
```

## Update

```bash
brew update
brew upgrade --cask lobehub
```

## Uninstall

```bash
brew uninstall --cask --zap lobehub
```

## Available casks

| Cask      | Channel | Description                                  |
| --------- | ------- | -------------------------------------------- |
| `lobehub` | stable  | LobeHub desktop app — AI chat client for multiple model providers |

## Releasing

New versions are bumped automatically when a stable release is published on
[`lobehub/lobehub`](https://github.com/lobehub/lobehub/releases). The bump
workflow opens a PR which is then merged.

To trigger manually:

```bash
gh workflow run bump-cask.yml -R lobehub/homebrew-tap \
  -f cask=lobehub -f version=<X.Y.Z>
```
