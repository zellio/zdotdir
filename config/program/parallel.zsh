#!/usr/bin/env zsh

is_installed parallel || return

export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
