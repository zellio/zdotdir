#!/usr/bin/env zsh

is_installed grep || return

export GREP_COLORS='ms=01;32:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
alias grep='grep --color=auto'
