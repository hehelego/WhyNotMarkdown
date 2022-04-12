# SECTION: env
#
set -gx TERMINAL alacritty
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER "nvim +Man!"


# SECTION: alias and abbr
#
alias ls="exa"
alias ll="exa --long --group-directories-first"
alias la="exa --long --all --group-directories-first"
alias tree="exa --tree"
alias tree-list="exa --tree --long --all"
alias fzff="fd --hidden --type file      | fzf --multi --cycle --preview='stat {}'"
alias fzfd="fd --hidden --type directory | fzf --multi --cycle --preview='exa -F1 {}'"
alias bat="bat --pager=less"
alias cat="bat --plain"


# SECTION: zoxide
#
set -gx _ZO_FZF_OPTS "--cycle --preview='exa -F1 {2..}'"
zoxide init fish | source


# SECTION: fzf
#
set -gx FZF_DEFAULT_COMMAND "fd -H --type file"
set -gx FZF_DEFAULT_OPTS "--cycle"


# SECTION: starship
#
if not test "$TERM" = "linux"
    set -gx STARSHIP_CONFIG ~/.config/starship/config.toml
    starship init fish | source
end
