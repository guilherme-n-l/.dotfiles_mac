#################
#   Behavior    #
#################
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HYPHEN_INSENSITIVE='true'
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

#################
# Customization #
#################
autoload -U colors && colors

function update_prompt() {
    if [[ -d .git ]]; then
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        PS1="%{$fg[yellow]%}%~%{$reset_color%} %{$fg[green]%}@$branch%{$reset_color%} %{$fg[cyan]%}%% %{$reset_color%}"
    else
        PS1="%{$fg[yellow]%}%~%{$reset_color%} %{$fg[cyan]%}%% %{$reset_color%}"
    fi
}

update_prompt

ran_git=false
function update_on_git() {
    if [[ ran_git ]]; then
        update_prompt
        ran_git=false
        return
    fi

    if [[ $(alias $1) == git* ]]; then
        ran_git=true
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd update_prompt
add-zsh-hook preexec update_on_git
add-zsh-hook precmd update_on_git


#################
#   bindings    #
#################
function yz() {
    local tmp="$(mktemp -t "yazi-cwd.xxxxxx")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$pwd" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
alias sd='sudo shutdown -h now'
alias rb='sudo shutdown -r now'
alias fzfd='fd --hidden --type d | fzf'
alias fcd='cd "$(fzfd)"'
alias lg='lazygit'
alias gs='git status'
alias gc='git commit'
alias gcfg='git config'
alias gco='git checkout'
alias gf='git fetch origin'
alias gp='git pull'
alias gp='git push'
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%c(bold blue)%h%c(reset) - %c(bold cyan)%ad%c(reset) %c(bold green)(%ar)%c(reset)%c(bold yellow)%d%c(reset)%n''%c(white)%s%c(reset) %c(dim white)- %an%c(reset)' --all"
alias gwa='git worktree add'
alias gwr='git worktree remove'
alias gwl='git worktree list'
alias bu='blueutil'
alias install='brew install'
alias remove='brew remove'

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

export EDITOR=nvim
export DYLD_LIBRARY_PATH=/usr/local/lib


source /opt/homebrew/Cellar/zsh-syntax-highlighting/0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
