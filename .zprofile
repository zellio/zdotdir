#!/usr/bin/env zsh

### Normalize System Variables

export TERM="${TERM:-xterm-color}"
export TERMINAL="${TERMINAL:-xterm}"
export UID="${UID:-$(id -u)}"
export USER="${USER:-$(id -un)}"
export GID="${GID:-$(id -g)}"
export GROUP="${GROUP:-$(id -gn)}"
export HOME="${HOME:-$(getent passwd "$USER" | cut -d: -f6)}"
export HOSTNAME="${HOSTNAME:-$(uname -n)}"
export IFS="${IFS:-$' \t\n\0'}"
export OSTYPE="${OSTYPE:-$(uname)}"
export MACHINE="${MACHINE:-$(uname -m)}"
export TZ="America/New_York"
export LANG="en_US.UTF-8"
export LANGUAGE="en"
export LC_ALL="en_US.UTF-8"

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

### Less setup

export PAGER='less'
export LESS='-g -i -M -R -S -w -z-4'
if (( $#commands[(i)lesspipe(|.sh)] )); then
	export LESSOPEN="|/usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

### Quick file read via `< file'

if [[ ! -z "$READNULLCMD" ]]; then
	READNULLCMD="$PAGER"
fi

### Functions

function safe_source
{
	[ -a "$1" ] && source "$1"
}

function is_installed
{
	command -v "$1" >/dev/null 2>&1
}

is_installed systemctl &&
	eval "$(/usr/bin/systemctl --user show-environment 2>/dev/null)"
