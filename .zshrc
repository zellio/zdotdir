#!/usr/bin/env zsh

export zzz_rc=1

case "$TERM" in
	tramp)
		# TRAMP is really picky so just disable zsh
		unsetopt zle
		unsetopt prompt_cr
		unsetopt prompt_subst

		if whence -w precmd >/dev/null; then
			unfunction precmd
		fi

		if whence -w preexec >/dev/null; then
			unfunction preexec
		fi
		PS1='$ '

		return
		;;

	xterm*)
		for term in xterm-256color xterm-color xterm; do
			if infocmp "$term" >/dev/null 2>&1; then
				export TERM="$term"
				break
			fi
		done
		;;
esac

### Initialize dynamic path building

typeset -gUT PATH path :
typeset -gUT CDPATH cdpath :
typeset -gUT FPATH fpath :
typeset -gUT MAILPATH mailpath :

typeset -Ua \
	path_dirs_append \
	path_dirs_prepend \
	path_dirs_program \
	path_dirs_system \
	path_dirs_user

path_dirs_prepend=(
    "$HOME"/bin
    "$HOME"/.bin
    "$HOME"/.local/bin
)

path_dirs_system=(
	/usr/local/bin
	/usr/local/sbin
	/usr/bin
	/usr/sbin
	/bin
	/sbin
)

### Normalize path for loading, we'll set it later

case "$MACHINE-$OSTYPE" in
	arm*-darwin*|aarch*-darwin*)
		path=(/opt/homebrew/bin /opt/homebrew/sbin $path_dirs_system)
		;;

	*)
		path=($path_dirs_prepend $path_dirs_system)
		;;
esac

### Load configuration

for config (
		"$ZDOTDIR"/config/shell/**/*.zsh(.N)
		"$ZDOTDIR"/config/os/**/*.zsh(.N)
		"$ZDOTDIR"/config/prog/**/*.zsh
		"$ZDOTDIR"/config/custom/**/*.zsh(.N)
	); do
	source "$config:A"
done

unset config

### Load functions

fpath=(
	"$ZDOTDIR"/functions
	"$ZDOTDIR"/functions/***(FN)
	"$ZDOTDIR"/completions
	"$ZDOTDIR"/completions/***(FN)
	$fpath
)

for func (
		"$ZDOTDIR"/functions/***(.N)
		"$ZDOTDIR"/completions/***(.N)
	); do
	autoload "$func:t"
done

unset func

### Compinit setup

if [ ! -d "$XDG_STATE_HOME"/zsh ]; then
	mkdir -p "$XDG_STATE_HOME"/zsh
fi

autoload -U compinit
compinit -i -d "$XDG_STATE_HOME"/zsh/zshcompdump

autoload -U +X bashcompinit
compinit -i -d "$XDG_STATE_HOME"/zsh/bashcompdump

### Build path variable

path=()
for dir (
	$path_dirs_prepend
	$path_dirs_user
	$path_dirs_program
	$path_dirs_system
	$path_dirs_append
); do
	[ -d "$dir" ] || continue
	path=($path $dir)
done

export path PATH

unset \
	path_dirs_prepend \
	path_dirs_user \
	path_dirs_program \
	path_dirs_system \
	path_dirs_append \
	dir

### Post config

for config (
		"$ZDOTDIR"/config/post/**/*.zsh(.N)
	); do
	source "$config:A"
done

unset config

### .zshrc ends here
