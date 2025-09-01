# My Dotfiles (GNU Stow版)

GNU Stowを使った個人開発環境設定ファイル管理

## 🏗️ 現在の構成

### 設定ファイル (Stow管理)
- **zsh** - Zsh設定 (43行のシェル設定)
- **git** - Git設定
- **ghostty** - Ghostty端末設定
- **tmux** - tmux設定 (新形式: ~/.config/tmux/)
- **mise** - 多言語ランタイムマネージャー設定

### パッケージ管理
- **homebrew** - Brewfileによるパッケージ管理
  - 開発ツール (git, gh, neovim, docker等)
  - GUIアプリケーション (Ghostty, JetBrains Toolbox, Notion等)
  - フォント・ユーティリティ

## 🚀 クイックスタート

### 新環境でのセットアップ
```bash
# リポジトリクローン
git clone git@github.com:yttkhs/dotfiles.git ~/dotfiles

# 完全自動セットアップ (Homebrew + Stow + 設定ファイル)
cd ~/dotfiles
./scripts/bin/setup-dotfiles
```

### 個別セットアップ

#### Homebrewパッケージのみ
```bash
cd ~/dotfiles
./scripts/bin/setup-homebrew
```

#### 設定ファイルのみ (Stow)
```bash
cd ~/dotfiles
stow zsh git tmux ghostty mise
```

## 📦 Brewfile管理

### パッケージの追加
```bash
# 新しいパッケージをインストール
brew install <package>
# または
brew install --cask <app>

# Brewfileを更新
cd ~/dotfiles/homebrew
brew bundle dump --force --describe
```

### 他環境への同期
```bash
cd ~/dotfiles/homebrew
brew bundle
```

### 不要なパッケージの削除
```bash
cd ~/dotfiles/homebrew
brew bundle cleanup
