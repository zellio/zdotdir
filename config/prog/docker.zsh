#!/usr/bin/env zsh

is_installed docker || return

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export DOCKER_BUILDKIT='1'
export BUILDKIT_PROGRESS='plain'
export COMPOSE_HTTP_TIMEOUT='120'

### docker.zsh ends here
