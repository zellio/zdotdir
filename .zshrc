#!/usr/bin/env zsh

### TRAMP is really picky so just disable zsh

if [[ "$TERM" == "tramp" ]]; then
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
fi

### Initialize dynamic path building

typeset -gU cdpath fpath mailpath path

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
	/usr/local/bin /usr/local/sbin
	/usr/bin /usr/sbin
	/bin /sbin
)

path_dirs_append=(
	/Library/Apple/usr/bin
)


# Normalize path for loading, we'll set it later
case "$MACHINE-$OSTYPE" in
	arm*-darwin*)
		path=(/opt/homebrew/bin /opt/homebrew/sbin $path_dirs_system)
		;;

	*)
		path=($path_dirs_system)
		;;
esac

### Load configuration
for config (
		"${ZDOTDIR}/config/zsh"/*.zsh(N)
		"${ZDOTDIR}/config/program"/*.zsh(N)
		"${ZDOTDIR}/custom"/**/*.zsh(N)
		"${ZDOTDIR}/config/system"/*.zsh(N)
		"${ZDOTDIR}/post-init"/**/*.zsh(N)
	); do
	source "$config:A"
done

### Load functions

fpath=(
	"${ZDOTDIR}/functions"/***/(-/)
	"${ZDOTDIR}/completions"/***/(-/)
	$fpath
)

for func (
		"${ZDOTDIR}/functions"/***/*(.N)
		"${ZDORDIR}/completions"/***/*(.N)
	); do
	autoload "$func:t"
done

### Compinit setup

if [ ! -d "${XDG_STATE_HOME}/zsh" ]; then
	mkdir -p "${XDG_STATE_HOME}/zsh"
fi

autoload -U compinit
compinit -i -d "${XDG_STATE_HOME}/zsh/zshcompdump"

autoload -U +X bashcompinit
compinit -i -d "${XDG_STATE_HOME}/zsh/bashcompdump"
