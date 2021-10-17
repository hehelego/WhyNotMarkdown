set -Ux FZF_DEFAULT_COMMAND "fd -H --type file"
set -x PATH $PATH "/home/hehelego/.cargo/bin"

alias ls="exa"
alias ll="exa --long"
alias la="exa --long --all"
alias tree="exa -T"
alias tree_ex="exa --long --all -T"
alias rm="trash"
alias fzff="fd -H --type file | fzf -m"
alias fzfd="fd -H --type directory | fzf -m"
alias bat="bat --pager=less"
alias back="cd_back_parent"

abbr --add -- - 'cd -'

zoxide init fish | source
