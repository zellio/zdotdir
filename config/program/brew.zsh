#!/usr/bin/env zsh

is_installed brew || return

export HOMEBREW_API_AUTO_UPDATE_SECS=300
export HOMEBREW_AUTOREMOVE=1
export HOMEBREW_AUTO_UPDATE_SECS=43200
export HOMEBREW_CACHE="$XDG_CACHE_HOME"/homebrew/cache
export HOMEBREW_CLEANUP_MAX_AGE_DAYS=30
export HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS=7
export HOMEBREW_LOGS="$XDG_CACHE_HOME"/homebrew/logs
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

### Handle Mac Arm BS

HOMEBREW_DIR=''
case "$MACHINE-$OSTYPE" in
	arm*-darwin*)
		HOMEBREW_DIR=/opt/homebrew
		;;

	*)
		HOMEBREW_DIR=/usr/local
		;;
esac

path_dirs_system=(
    "$HOMEBREW_DIR"/bin "$HOMEBREW_DIR"/sbin $path_dirs_system
)

### Update function paths

fpath=(
	"$HOMEBREW_DIR"/share/zsh/site-functions/***/(-/)
	$fpath
)

for func ( "$HOMEBREW_DIR"/share/zsh/site-functions/***/*(.N) ); do
	autoload "$func:t"
done

### Aliases

alias mtr="sudo mtr"

### Update paths

path_dirs_program=(
	$path_dirs_program
    "${(@f)$(find "$HOMEBREW_DIR"/Cellar -maxdepth 4 -name 'gnubin')}"
)

function brew-load-keg-flags
{
    set -x

    local -a kegs=(
        "${(@f)$(
            brew info --installed --json=v2 | jq --raw-output '.formulae[]|select(.keg_only)|.name'
        )}"
    )

    for keg ( $kegs ); do
        local keg_base="${HOMEBREW_DIR}/opt/${keg}"

        if [ -d "$keg_base"/lib ]; then
            ldflags=($ldflags "-L$keg_base"/lib)
        fi

        if [ -d "$keg_base"/include ]; then
            cppflags=($cppflags "-I$keg_base"/include)
        fi

        if [ -d "$keg_base"/lib/pkgconfig ]; then
            pkg_config_path=($pkg_config_path "$keg_base"/lib/pkgconfig)
        fi
    done
}

typeset -UT LDFLAGS='' ldflags ' '
typeset -UT CFLAGS='' cflags ' '
typeset -UT CPPFLAGS='' cppflags ' '
typeset -UT PKG_CONFIG_PATH='' pkg_config_path ':'

export LDFLAGS CFLAGS CPPFLAGS PKG_CONFIG_PAHT
