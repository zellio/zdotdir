#!/usr/bin/env zsh

[ -r /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ] || return

source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

path_dirs_program=(
	/run/current-system/sw/bin
	"$XDG_STATE_HOME"/nix/profile/bin
	/nix/var/nix/profiles/default/bin
	$path_dirs_program
)
