#!/usr/bin/env zsh

local evergreen_config="$XDG_CONFIG_HOME"/evergreen/evergreen.yaml

if [ -r "$evergreen_config" ]; then
	alias evergreen="evergreen --config $evergreen_config"
fi

unset evergreen_config
