#!/usr/bin/env zsh

# is_installed rust || return

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

path_prepend+=("$CARGO_HOME/bin")
