#!/usr/bin/env zsh

export GOPATH="${GOPATH:-"$XDG_DATA_HOME"/go}"
export GOPROXY="${GOPROXY:-https://proxy.golang.org,direct}"

if is_installed goenv; then
	export GOENV_ROOT="${GOENV_ROOT:-"$XDG_DATA_HOME"/goenv}"
	export GOENV_GOPATH_PREFIX="${GOENV_GOPATH_PREFIX:-"$GOPATH"}"

	path_dirs_user+=("$GOENV_ROOT"/shims)

	function goenv
	{
		eval "$(
				command goenv init - "$PROFILE_SHELL" | sed -ne '/goenv()/,/^}$/p'
					)"
		goenv "$@"
	}
fi
