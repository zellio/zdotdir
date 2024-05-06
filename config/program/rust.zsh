#!/usr/bin/env zsh

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo

path_dirs_user+=("$CARGO_HOME/bin")
