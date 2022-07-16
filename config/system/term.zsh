#!/usr/bin/env zsh

case "$TERM" in
	xterm*)
		for term in xterm-256color xterm-color xterm; do
			if infocmp "$term" >/dev/null 2>&1; then
				export TERM="$term"
				break
			fi
		done
		;;
esac

unset term
