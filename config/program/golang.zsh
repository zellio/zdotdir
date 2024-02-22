#!/usr/bin/env zsh

is_installed goenv || return

export GOENV_ROOT="${GOENV_ROOT:-"$XDG_DATA_HOME"/goenv}"

path_dirs_user+=("$GOENV_ROOT"/shims)

function goenv
{
	eval "$(
		command goenv init - "$PROFILE_SHELL" | sed -ne '/goenv()/,/^}$/p'
	)"
	goenv "$@"
}
