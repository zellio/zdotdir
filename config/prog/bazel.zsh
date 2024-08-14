#!/usr/bin/env bash

is_installed bazel || return

alias bazel="command bazel --bazelrc XDG_CONFIG_HOME/bazel/bazelrc"

### bazel.zsh ends here
