# homebrew
export PATH="/opt/homebrew/bin:$PATH"

# prezto  init setup
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Oh My Zsh tmux plugin configuration
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOSTART_ONCE=false
export ZSH_TMUX_AUTOCONNECT=false
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

# mise
eval "$(mise activate zsh)"

# fzf shell integration (managed by Homebrew)
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# fzf + ghq alias setting
alias cdghq='cd $(ghq root)/$(ghq list | fzf --preview "ls -la $(ghq root)/{}")'
