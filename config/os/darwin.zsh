#!/usr/bin/env zsh

[[ "$OSTYPE" = 'darwin'* ]] || return

path_dirs_system=(
	"${(ps/:/)"$(env - /usr/libexec/path_helper -c | cut -d'"' -f2)"}"
)

export XDG_RUNTIME_DIR="$XDG_CACHE_HOME"/run

if [ ! -d "$XDG_RUNTIME_DIR" ]; then
	mkdir "$XDG_RUNTIME_DIR"
	chmod 0700 "$XDG_RUNTIME_DIR"
fi
