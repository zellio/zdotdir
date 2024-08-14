#!/usr/bin/env zsh

### Default XDG variables

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME"/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME"/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME"/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-"$HOME"/.local/state}"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/"$UID"}"
export XDG_BIN_DIR="${XDG_BIN_DIR:-"$HOME"/.local/bin}"

### Set ZDOTDIR

export ZDOTDIR="${ZDOTDIR:-"$XDG_CONFIG_HOME"/zsh}"

### Normalize System Variables

export TERM="${TERM:-xterm-color}"
export TERMINAL="${TERMINAL:-xterm}"
export UID="${UID:-$(id -u)}"
export USER="${USER:-$(id -un)}"
export GID="${GID:-$(id -g)}"
export GROUP="${GROUP:-$(id -gn)}"
export HOME="${HOME:-$(getent passwd "$USER" | cut -d: -f6)}"
export HOSTNAME="${HOSTNAME:-$(uname -n)}"
export IFS="${IFS:-$' \t\n\0'}"
export OSTYPE="${OSTYPE:-$(uname)}"
export MACHINE="${MACHINE:-$(uname -m)}"
export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"

### Load zprofile in non-login scenarios

if [[ ! -o login && -s "$ZDOTDIR"/.zprofile ]]; then
	source "$ZDOTDIR"/.zprofile
fi

### .zshenv ends here
