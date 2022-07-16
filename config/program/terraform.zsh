#!/usr/bin/env zsh

is_installed terraform || return

export TF_CLI_CONFIG_FILE="${XDG_CONFIG_HOME}"/terraform/config.tfrc
export TF_PLUGIN_CACHE_DIR="${XDG_CACHE_HOME}"/terraform/plugin

test -d "$TF_PLUGIN_CACHE_DIR" || mkdir -p "$TF_PLUGIN_CACHE_DIR"
