#!/usr/bin/env zsh

is_installed systemctl || return

eval "$(/usr/bin/systemctl --user show-environment 2>/dev/null)"

### systemd.zsh ends here
