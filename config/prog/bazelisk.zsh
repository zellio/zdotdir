#!/usr/bin/env bash

is_installed bazelisk || return

alias bazel="command bazelisk --bazelrc $XDG_CONFIG_HOME/bazel/bazelrc"
alias bazelisk="command bazelisk --bazelrc $XDG_CONFIG_HOME/bazel/bazelrc"

### bazelisk.zsh ends here
