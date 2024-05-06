#!/usr/bin/env zsh

ASDF_DIR="${ASDF_DIR:-"$XDG_DATA_HOME"/asdf}"

[ -d "$ASDF_DIR" ] || return

export ASDF_DIR
export ASDF_CONFIG_FILE="${ASDF_CONFIG_FILE:-"$XDG_CONFIG_HOME"/asdf/asdfrc}"
export ASDF_DATA_DIR="${ASDF_DATA_DIR:-"$ASDF_DIR"}"
export ASDF_FORCE_PREPEND="${ASDF_FORCE_PREPEND:-'no'}"

source "$ASDF_DIR"/asdf.sh

path_dirs_user+=("$ASDF_DIR"/bin "$ASDF_DIR"/shims)
