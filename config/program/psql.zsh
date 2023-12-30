#!/usr/bin/env zsh

is_installed psql || return

export PSQL_HISTORY="$XDG_DATA_HOME"/psql_history
