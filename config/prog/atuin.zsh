#!/usr/bin/evn zsh

is_installed atuin || return

eval "$(atuin init zsh)"

alias history='command atuin history list'

### atuin.zsh ends here
