#!/usr/bin/env zsh

is_installed emacs || return

if is_installed launchctl; then
	EMACS_SOCKET_NAME='launchd-user.plist'
elif is_installed systemctl; then
	EMACS_SOCKET_NAME='systemd-user.service'
fi

declare emacsclient
emacsclient="$(command -v emacsclient)"

declare -a emacsclient_opts=(
	"--socket-name=$EMACS_SOCKET_NAME"
	'--create-frame'
	'--alternate-editor=''emacs -nw'''
)

export PASSWORD_STORE_DIR=
export EDITOR="$emacsclient --tty ${emacsclient_opts[@]}"
export VISUAL="$emacsclient ${emacsclient_opts[@]}"

unset emacsclient emacsclient_opts EMACS_SOCKET_NAME

### emacs.zsh ends here
