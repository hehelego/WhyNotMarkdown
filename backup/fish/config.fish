# SECTION: alias and abbr
#
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

abbr --add -- - "cd -"



# SECTION: zoxide
#
zoxide init fish | source



# SECTION: fzf
#
set -gx FZF_DEFAULT_COMMAND "fd -H --type file"




# SECTION: starship
#
set -gx STARSHIP_CONFIG ~/.config/starship/config.toml
if not test "$TERM" = "linux"
    # see https://github.com/starship/starship/pull/3160/commits/512f037727f9990f6f790872c6a15e0675d4beb7
    # see https://github.com/starship/starship/pull/3160

    # starship init fish | source

    function fish_prompt
        switch "$fish_key_bindings"
            case fish_hybrid_key_bindings fish_vi_key_bindings
                set STARSHIP_KEYMAP "$fish_bind_mode"
            case '*'
                set STARSHIP_KEYMAP insert
        end
        set STARSHIP_CMD_PIPESTATUS $pipestatus
        set STARSHIP_CMD_STATUS $status
        # Account for changes in variable name between v2.7 and v3.0
        set STARSHIP_DURATION "$CMD_DURATION$cmd_duration"
        set STARSHIP_JOBS (count (jobs -p))
        starship prompt --status=$STARSHIP_CMD_STATUS --pipestatus=$STARSHIP_CMD_PIPESTATUS --keymap=$STARSHIP_KEYMAP --cmd-duration=$STARSHIP_DURATION --jobs=$STARSHIP_JOBS
    end

    function fish_right_prompt
        starship prompt --right --status=$STARSHIP_CMD_STATUS --pipestatus=$STARSHIP_CMD_PIPESTATUS --keymap=$STARSHIP_KEYMAP --cmd-duration=$STARSHIP_DURATION --jobs=$STARSHIP_JOBS
    end

    # Disable virtualenv prompt, it breaks starship
    set -g VIRTUAL_ENV_DISABLE_PROMPT 1

    # Remove default mode prompt
    builtin functions -e fish_mode_prompt

    set -gx STARSHIP_SHELL "fish"

    # Set up the session key that will be used to store logs
    set -gx STARSHIP_SESSION_KEY (random 10000000000000 9999999999999999)
end
