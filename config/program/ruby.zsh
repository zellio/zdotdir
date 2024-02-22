#!/usr/bin/env zsh

is_installed rbenv || is_installed ruby || return

export GEMRC="$XDG_CONFIG_HOME"/gem/gemrc

export GEM_HOME="${XDG_DATA_HOME}"/gem
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}"/gem

export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph

### Setup rbenv

export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
if [ -d "$RBENV_ROOT" ]; then
	path_dirs_user+=("$RBENV_ROOT"/shims)

    function rbenv
    {
        eval "$(
            command rbenv init - "$PROFILE_SHELL" | sed -ne '/rbenv()/,/^}$/p'
        )"
        rbenv "$@"
    }

	export RBENV_ROOT
fi


### Setup rvm

rvm_path="$XDG_DATA_HOME"/rvm
if [ -s "$rvm_path"/scripts/rvm ]; then
	export rvm_path

	function rmv
	{
		source "$rvm_path"/scripts/rvm
		rvm "$@"
	}

	export GEM_HOME=
fi
