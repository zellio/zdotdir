#!/usr/bin/env bash

CARGO_HOME="$XDG_DATA_HOME"/cargo

[ -d "$CARGO_HOME" ] || return

path_dirs_user+=("$CARGO_HOME/bin")

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME
