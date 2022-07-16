#!/usr/bin/env zsh

GOPATH="$XDG_DATA_HOME"/go

test -d "$GOPATH" || return

path_prepend+=(
	"${GOPATH}/bin" "${GOROOT}/bin"
)

case "$MACHINE-$OSTYPE" in
	arm*-darwin*)
		GOROOT='/opt/homebrew/opt/go/libexec'
		;;
esac

export GOPATH
export GOROOT
