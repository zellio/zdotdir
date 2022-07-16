#!/usr/bin/env zsh

setopt append_history
setopt bang_hist
setopt extended_history
setopt NO_hist_allow_clobber
setopt NO_hist_beep
setopt hist_expire_dups_first
setopt hist_fcntl_lock
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_lex_words
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_by_copy
setopt hist_save_no_dups
setopt hist_verify
setopt NO_inc_append_history
setopt No_inc_append_history_time
setopt share_history

export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTSIZE=100000
export SAVEHIST=100000
