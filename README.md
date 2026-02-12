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
| fzf | コマンドラインファジーファインダー (ghq 連携) |
| tinty | ターミナルテーマ管理 (base16/base24) |
| direnv | ディレクトリ別環境変数 |
| workmux | ワークスペース管理 |
| Claude Code | AI コーディングアシスタント |

## リポジトリ構成

```
.
├── dot_config/
│   ├── ghostty/          # ターミナルエミュレータ
│   ├── mise/             # ランタイムバージョン管理
│   ├── nvim/             # Neovim (NvChad)
│   ├── sheldon/          # zsh プラグイン管理
│   ├── starship.toml     # プロンプト
│   ├── tinted-theming/   # テーマ管理
│   ├── tmux/             # tmux 設定
│   └── workmux/          # ワークスペース管理
├── dot_claude/           # Claude Code 設定
├── homebrew/
│   └── Brewfile          # Homebrew パッケージ一覧
├── dot_gitconfig         # Git 設定
├── dot_tmux.conf         # tmux エントリポイント
├── dot_zpreztorc         # Prezto 設定
├── dot_zshrc.tmpl        # zsh 設定 (chezmoi テンプレート)
├── run_onchange_before_install-homebrew.sh.tmpl
├── run_once_before_install-prezto.sh
└── run_once_after_install-tmux-plugins.sh
```

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

## セットアップスクリプト

`chezmoi init --apply` 時に以下のスクリプトが自動実行される。

| スクリプト | タイミング | 内容 |
|---|---|---|
| `run_onchange_before_install-homebrew.sh.tmpl` | Brewfile 変更時 | Homebrew インストール & `brew bundle` |
| `run_once_before_install-prezto.sh` | 初回のみ | Prezto のクローン |
| `run_once_after_install-tmux-plugins.sh` | 初回のみ | TPM & tmux プラグインのインストール |

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
