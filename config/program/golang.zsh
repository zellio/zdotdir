#!/usr/bin/env zsh

is_installed goenv || return

GOENV_ROOT="${GOENV_ROOT:-$XDG_DATA_HOME/goenv}"
if [ -d "$GOENV_ROOT" ]; then
	path_dirs_user+=("$GOENV_ROOT/shims")

    function goenv
    {
        eval "$(
            command goenv init - "$PROFILE_SHELL" |
                sed -n '/^[[:alpha:]]\+env[[:space:]]*([[:space:]]*)[[:space:]]*{/,$p'
        )"
        goenv "$@"
    }

    export GOENV_ROOT
fi
