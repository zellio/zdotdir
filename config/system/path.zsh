#!/usr/bin/env zsh

path=()
for dir ($path_prepend $path_system $path_append); do
	[ -d "$dir" ] || continue
	path=($path $dir)
done

export path PATH

unset dir
