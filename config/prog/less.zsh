#!/usr/bin/evn zsh

is_installed less || return

export LESS='-g -i -M -R -S -w -z-4'

if (( $#commands[(i)lesspipe(|.sh)] )); then
	export LESSOPEN="|/usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

### less.zsh ends here
