# PATH
export "PATH=/usr/local/bin:$PATH"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# prezto  init setup
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Oh My Zsh tmux plugin configuration
export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_AUTOSTART_ONCE=false
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_AUTOQUIT=false
export ZSH_TMUX_FIXTERM=true

# zplug
if [[ -f /opt/homebrew/Cellar/zplug/2.4.2/init.zsh ]]; then
    source /opt/homebrew/Cellar/zplug/2.4.2/init.zsh

    # Core plugins
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "agkozak/zsh-z"
    zplug "sainnhe/tmux-fzf"
    zplug "plugins/tmux", from:oh-my-zsh

    if ! zplug check --verbose; then
        printf "Install zplug plugins? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi
    zplug load
fi

# Direnv
eval "$(direnv hook zsh)"

# Sheldon
eval "$(sheldon source)"

# Zsh Theme
SPACESHIP_PROMPT_ASYNC=FALSE

# Bun
export PATH="/Users/yuta/.bun/bin:$PATH"

# Google Cloud SDK
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# Node
export NODE_OPTIONS="--max-old-space-size=4096"

# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Created by `pipx` on 2024-08-12 22:15:22
export PATH="$PATH:/Users/yuta/.local/bin"

# fzf + ghq alias setting
alias cdghq='cd $(ghq root)/$(ghq list | fzf --preview "ls -la $(ghq root)/{}")'

# Atcoder Online Judge Tools Alias Setting
alias ojt='oj t -c " cpp main.cpp" -d test'

# Workmux
alias wm='workmux'

# Claude
export PATH="$HOME/.claude/local:$PATH"

# fzf shell integration (managed by Homebrew)
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# fzf + ghq alias setting
alias cdghq='cd $(ghq root)/$(ghq list | fzf --preview "ls -la $(ghq root)/{}")'

# Starship
eval "$(starship init zsh)"

# mise
eval "$(mise activate zsh)"

# Workmux completions
eval "$(workmux completions zsh)"
