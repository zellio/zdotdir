#!/usr/bin/env zsh

ASDF_DIR="${ASDF_DIR:-"$XDG_DATA_HOME"/asdf}"

[ -d "$ASDF_DIR" ] || return

export ASDF_DIR
export ASDF_CONFIG_FILE="${ASDF_CONFIG_FILE:-"$XDG_CONFIG_HOME"/asdf/asdfrc}"
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-"$ASDF_DIR"}"
export ASDF_FORCE_PREPEND="${ASDF_FORCE_PREPEND:-'no'}"

# Reimplementation of asdf wrapper function

function asdf {
	case "$1" in
		shell)
			if ! shift; then
				printf '>>> \e[38;2;255;0;0mERROR\e[0m: asdf failed to shift args\n' >&2
				return 1
			fi

			eval "$(asdf export-shell-version sh "$@")"
			;;
		*)
			command asdf "$@"
			;;
	esac
}

path_dirs_user+=("$ASDF_DIR"/bin "$ASDF_DIR"/shims)

# Temporarily inject asdf to path for configuration

PATH="${ASDF_DIR}/bin:${ASDF_DIR}/shims:$PATH"

### asdf.zsh ends here
