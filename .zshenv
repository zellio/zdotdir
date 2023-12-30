#!/usr/bin/env zsh

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME"/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME"/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME"/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-"$HOME"/.local/state}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/"$UID"}"

export XDG_BIN_DIR="${XDG_BIN_DIR:-$HOME/.local/bin}"

# Plaster over osx weirdness
if [ ! -w "$XDG_RUNTIME_DIR" ]; then
	XDG_RUNTIME_DIR="$XDG_CACHE_HOME"/run
fi

export ZDOTDIR="${ZDOTDIR:-"$XDG_CONFIG_HOME"/zsh}"

# Also load zprofile in non-login scenarios
if [[ ! -o login && -s "$ZDOTDIR"/.zprofile ]]; then
	source "$ZDOTDIR"/.zprofile
fi
