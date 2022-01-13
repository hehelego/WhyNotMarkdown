# SECTION: alias and abbr
#
alias ls="exa"
alias ll="exa --long"
alias la="exa --long --all"
alias tree="exa -T"
alias tree_ex="exa --long --all -T"
alias fzff="fd -H --type file | fzf -m"
alias fzfd="fd -H --type directory | fzf -m"
alias bat="bat --pager=less"
alias cat="bat --plain"
alias codepy="code --enable-proposed-api ms-toolsai.jupyter ."



# SECTION: zoxide
#
set -gx _ZO_FZF_OPTS ''
zoxide init fish | source



# SECTION: fzf
#
set -gx FZF_DEFAULT_COMMAND "fd -H --type file"


# SECTION: starship
#
if not test "$TERM" = "linux"
    set -gx STARSHIP_CONFIG ~/.config/starship/config.toml
    starship init fish | source
end
