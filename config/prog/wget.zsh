#!/usr/bin/env bash

is_installed wget || return

alias wget="wget --hsts-file='$XDG_DATA_HOME/wget/history'"

### wget.zsh ends here
