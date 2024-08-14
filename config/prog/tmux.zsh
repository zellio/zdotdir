#!/usr/bin/env zsh

is_installed tmux || return

export TMUX_PLUGIN_MANAGER_PATH="$XDG_DATA_HOME"/tmux/plugins/tpm

### tmux.zsh ends here
