#!/usr/bin/env zsh

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

path_dirs_user+=("$CARGO_HOME/bin")
