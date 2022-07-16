#!/usr/bin/env zsh

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

unset dir
