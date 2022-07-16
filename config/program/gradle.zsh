#!/usr/bin/env zsh

is_installed gradle || return

export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
