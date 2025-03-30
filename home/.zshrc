#################
#   Behavior    #
#################
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY


#################
# Customization #
#################
autoload -U colors && colors
PS1="%{$fg[yellow]%}%~%{$reset_color%} %{$fg[cyan]%}%% %{$reset_color%}"


#################
#   VARIABLES   #
#################
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HYPHEN_INSENSITIVE='true'

declare -A zsh_aliases=(
['sd']='sudo shutdown -h now'
['rb']='sudo shutdown -r now'
['fzfd']='fd --hidden --type d | fzf'
['fcd']='cd "$(fzfd)"'
['lg']='lazygit'
['gs']='git status'
['gc']='git commit'
['gcfg']='git config'
['gco']='git checkout'
['gf']='git fetch origin'
['gp']='git pull'
['gp']='git push'
['gl']="git log \
    --graph \
    --abbrev-commit \
    --decorate \
    --format=format:'%c(bold blue)%h%c(reset) - \
    %c(bold cyan)%ad%c(reset) %c(bold green)(%ar)%c(reset)%c(bold yellow)%d%c(reset)%n''%c(white)%s%c(reset) %c(dim white) - \
    %an%c(reset)' --all"
    ['gwa']='git worktree add'
    ['gwr']='git worktree remove'
    ['gwl']='git worktree list'
    ['bu']='blueutil'
    ['install']='brew install'
    ['remove']='brew remove'
    ['..']='cd ..'
)

declare -A zsh_binds=(
['^[[1;3C']='forward-word'
['^[[1;3D']='backward-word'
['^[[1;5C']='forward-word'
['^[[1;5D']='backward-word'
['^R']='history-incremental-search-backward'
)

declare -A zsh_exports=(
['EDITOR']='nvim'
['DYLD_LIBRARY_PATH']='/usr/local/lib'
)

zsh_sources=(
'/opt/homebrew/Cellar/zsh-syntax-highlighting/0.8.0/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
)


#################
#   Bindings    #
#################

function yz() {
    local tmp="$(mktemp -t "yazi-cwd.xxxxxx")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$pwd" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

eval "$(/opt/homebrew/bin/brew shellenv)"

for k in ${(k)zsh_aliases}; alias "$k"="${zsh_aliases[$k]}";
for k in ${(k)zsh_binds}; bindkey "$k" "${zsh_binds[$k]}";
for k in ${(k)zsh_exports}; export "$k"="${zsh_exports[$k]}";
for i in $zsh_sources; source $i;
