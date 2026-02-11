# dotfiles

[chezmoi](https://www.chezmoi.io/) で管理する個人開発環境の設定ファイル群。

## 管理ツール

| ツール | 用途 |
|---|---|
| chezmoi | dotfiles 管理 |
| Homebrew | パッケージ管理 |
| zsh + Prezto | シェル + フレームワーク |
| sheldon | zsh プラグイン管理 |
| Neovim (NvChad) | エディタ |
| tmux + TPM | ターミナルマルチプレクサ |
| Ghostty | ターミナルエミュレータ |
| starship | プロンプト |
| mise | ランタイムバージョン管理 |
| tinty | ターミナルテーマ管理 (base16/base24) |
| direnv | ディレクトリ別環境変数 |
| workmux | ワークスペース管理 |

## クイックスタート

### 新規マシン

```bash
# 1. chezmoi をインストール
sh -c "$(curl -fsLS get.chezmoi.io)"

# 2. クローン & 適用 (Homebrew, Prezto, TPM も自動セットアップ)
chezmoi init --apply git@github.com:yttkhs/dotfiles.git
```

### 既存のリポジトリを使う場合

```bash
# ghq 等で既にクローン済みの場合、source として指定
chezmoi init --source ~/Workspace/Repository/github.com/yttkhs/dotfiles --apply
```

## 日常的な使い方

```bash
# 設定ファイルを編集
chezmoi edit ~/.zshrc

# 変更内容をプレビュー
chezmoi diff

# 変更を適用
chezmoi apply

# ソースディレクトリで直接編集した場合
chezmoi re-add
```

## マシン固有の設定 (.local オーバーライド)

マシン固有の設定は `.local` ファイルに記述する。これらはリポジトリに含まれない。

- `~/.zshrc.local` - シェル設定のオーバーライド
- `~/.gitconfig.local` - Git 設定のオーバーライド（仕事用メールアドレス等）

## Brewfile 管理

Brewfile を変更すると、次回の `chezmoi apply` で自動的に `brew bundle` が再実行される。

```bash
# 新しいパッケージを追加後、Brewfile を更新
brew install <package>
cd "$(chezmoi source-path)/homebrew"
brew bundle dump --force --describe

# 変更を適用（brew bundle が自動実行される）
chezmoi apply
```
