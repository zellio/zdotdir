#!/usr/bin/env zsh

### Ruby Config

export GEMRC="$XDG_CONFIG_HOME"/gem/gemrc

export GEM_HOME="${XDG_DATA_HOME}"/gem
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}"/gem

export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

export SOLARGRAPH_CACHE="$XDG_CACHE_HOME"/solargraph

### rbenv config

RBENV_ROOT="$XDG_DATA_HOME"/rbenv
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

### ruby.zsh ends here
