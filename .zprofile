#!/usr/bin/env zsh

### XDG Variables

if [ -s "$XDG_CONFIG_HOME"/user-dirs.dirs ]; then
	source "$XDG_CONFIG_HOME"/user-dirs.dirs

	export \
		XDG_DESKTOP_DIR \
		XDG_DOCUMENTS_DIR \
		XDG_DOWNLOAD_DIR \
		XDG_MUSIC_DIR \
		XDG_PICTURES_DIR \
		XDG_VIDEOS_DIR \
		XDG_PROJECTS_DIR
fi

### Generic Settings

export DIRSTACKSIZE=50
export REPORTTIME=10
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'
export TIMEFMT="%J
Time: %U user | %S system | %P cpu | %*E total | %M KiB max RSS"

### Functions

function safe_source
{
	[ -a "$1" ] && source "$1"
}

function is_installed
{
	command -v "$1" >/dev/null 2>&1
}

### .zprofile ends here
