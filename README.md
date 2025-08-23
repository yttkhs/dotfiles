# My Dotfiles (GNU Stow版)

GNU Stowを使った個人開発環境設定ファイル管理

## 🏗️ 現在の構成

- **zsh** - Zsh設定 (43行のシェル設定)
- **git** - Git設定
- **alacritty** - Alacritty端末設定
- **tmux** - tmux設定 (新形式: ~/.config/tmux/)

## 🚀 クイックスタート

### 新環境でのセットアップ
```bash
# リポジトリクローン
git clone git@github.com:yttkhs/dotfiles.git ~/dotfiles

# GNU Stowインストール
brew install stow

# 自動セットアップ
cd ~/dotfiles
./scripts/bin/setup-dotfiles
