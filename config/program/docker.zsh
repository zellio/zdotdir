#!/usr/bin/env zsh

export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export DOCKER_BUILDKIT='1'
export DOCKER_DEFAULT_PLATFORM='linux/amd64'
export BUILDKIT_PROGRESS='plain'
export COMPOSE_HTTP_TIMEOUT='120'
