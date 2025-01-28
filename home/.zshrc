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

PS1="%{$fg[yellow]%}%~%{$reset_color%} %{$fg[cyan]%}%% %{$reset_color%}"

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

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

export EDITOR=nvim
