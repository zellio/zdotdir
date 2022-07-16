#!/usr/bin/env zsh

is_installed wget || return

alias wget="wget --hsts-file='$XDG_DATA_HOME/wget-hsts'"
