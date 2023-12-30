#!/usr/bin/env zsh

is_installed pipx || return

export PIPX_HOME="${PIPX_HOME:-"$XDG_DATA_HOME"/pipx}"
export PIPX_BIN_DIR="${PIPX_BIN_DIR:-$XDG_BIN_DIR}"
export USE_EMOJI=
