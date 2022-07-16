#!/usr/bin/env zsh

is_installed gpg || return

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
