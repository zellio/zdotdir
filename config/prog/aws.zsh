#!/usr/bin/env zsh

is_installed aws || return

export AWS_CLI_FILE_ENCODING='UTF-8'
export AWS_DEFAULT_OUTPUT='json'
export AWS_PAGER='cat'
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials

### aws.zsh ends here
