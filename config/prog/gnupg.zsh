#!/usr/bin/env zsh

is_installed gpg || return

export GPG_TTY="${GPG_TTY:-"$(tty)"}"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

### gnupg.zsh ends here
