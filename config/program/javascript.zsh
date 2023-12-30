#!/usr/bin/env zsh

NVM_DIR="$XDG_DATA_HOME"/nvm

test -d "$NVM_DIR" || return

export NVM_DIR

export NVM_SYMLINK_CURRENT=true
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history

path_dirs_user+=("$NVM_DIR"/current/bin)

source "$NVM_DIR/nvm.sh" --no-use
