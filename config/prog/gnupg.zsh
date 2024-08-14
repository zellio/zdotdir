#!/usr/bin/env zsh

is_installed gnupg || return

export GPG_TTY="${GPG_TTY:-"$(tty)"}"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

### gnupg.zsh ends here
