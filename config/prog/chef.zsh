#!/usr/bin/env zsh

CHEF_HOME='/home/chef-workstation'

[ -d "$CHEF_HOME" ] || return

path_dirs_program=("$CHEF_HOME"/bin $path_dirs_program)

export CHEF_HOME

### chef.zsh ends here
