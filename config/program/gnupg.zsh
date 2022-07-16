#!/usr/bin/evn zsh

is_installed gnupg || return

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
