#!/usr/bin/env zsh

SDKMAN_DIR="$XDG_DATA_HOME"/sdkman

test -d "$SDKMAN_DIR" || return

export SDKMAN_DIR
