#!/usr/bin/env

is_installed psql || return

export PSQL_HISTORY="$XDG_DATA_HOME"/psql_history

### postgresql.zsh ends here
