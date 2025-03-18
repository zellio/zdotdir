#!/usr/bin/env zsh

[[ "$OSTYPE" = 'darwin'* ]] || return


## Trust system for its own directories

path_dirs_system=(
	"${(ps/:/)"$(env - /usr/libexec/path_helper -c | cut -d'"' -f2)"}"
)


## Move XDG_RUNTIME_DIR to user controlled directory

export XDG_RUNTIME_DIR="$XDG_CACHE_HOME"/run

if [ ! -d "$XDG_RUNTIME_DIR" ]; then
	mkdir "$XDG_RUNTIME_DIR"
	chmod 0700 "$XDG_RUNTIME_DIR"
fi


## Correct XDG variables to match OSX directories

export XDG_DESKTOP_DIR="$HOME"/Desktop
export XDG_DOCUMENTS_DIR="$HOME"/Documents
export XDG_DOWNLOAD_DIR="$HOME"/Downloads
export XDG_MUSIC_DIR="$HOME"/Music
export XDG_PICTURES_DIR="$HOME"/Pictures
export XDG_VIDEOS_DIR="$HOME"/Videos
export XDG_PROJECTS_DIR="$HOME"/Projects


## Clean up docker config location

unset DOCKER_CONFIG

### darwin.zsh ends here
