#!/usr/bin/env zsh

[[ "$OSTYPE" = 'darwin'* ]] || return

path_dirs_system=(
	"${(ps/:/)"$(env - /usr/libexec/path_helper -c | cut -d'"' -f2)"}"
)
