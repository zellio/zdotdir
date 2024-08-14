#!/usr/bin/env zsh

### XDG Variables

if [[ -s "$XDG_CONFIG_HOME/user-dirs.dirs" ]]; then
	source "$XDG_CONFIG_HOME/user-dirs.dirs"
elif [[ "$OSTYPE" == darwin* ]]; then
	# We are faking xdg for osx
	export XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-${HOME}/Desktop}"
	export XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-${HOME}/Documents}"
	export XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-${HOME}/Downloads}"
	export XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-${HOME}/Music}"
	export XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-${HOME}/Pictures}"
	export XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-${HOME}/Videos}"
	export XDG_PROJECTS_DIR="${XDG_PROJECTS_DIR:-${HOME}/Projects}"
else
	export XDG_DESKTOP_DIR="${XDG_DESKTOP_DIR:-${HOME}/desktop}"
	export XDG_DOCUMENTS_DIR="${XDG_DOCUMENTS_DIR:-${HOME}/documents}"
	export XDG_DOWNLOAD_DIR="${XDG_DOWNLOAD_DIR:-${HOME}/downloads}"
	export XDG_MUSIC_DIR="${XDG_MUSIC_DIR:-${HOME}/music}"
	export XDG_PICTURES_DIR="${XDG_PICTURES_DIR:-${HOME}/images}"
	export XDG_VIDEOS_DIR="${XDG_VIDEOS_DIR:-${HOME}/videos}"
	export XDG_PROJECTS_DIR="${XDG_PROJECTS_DIR:-${HOME}/projects}"
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
