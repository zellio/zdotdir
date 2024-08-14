#!/usr/bin/env zsh

is_installed python || return

### Python Config

export PYTHONPATH='.'
export PYTHONUTF8='1'
export PYTHONPYCACHEPREFIX="${PYTHONPYCACHEPREFIX:-"$XDG_CACHE_HOME"}"/python
export PYTHONSTARTUP="${PYTHONSTARTUP:-"$XDG_CONFIG_HOME"}"/python/pythonrc

## Configure pipx

export PIPX_HOME="${PIPX_HOME:-"$XDG_DATA_HOME"/pipx}"
export PIPX_BIN_DIR="${PIPX_BIN_DIR:-$XDG_BIN_DIR}"
export USE_EMOJI=

if [ ! -d "$PYTHONPYCACHEPREFIX" ]; then
	mkdir -p "$PYTHONPYCACHEPREFIX"
fi

## Configure poetry

POETRY_HOME="$XDG_DATA_HOME"/poetry
if [ -d "$POETRY_HOME" ]; then
	export POETRY_CACHE_DIR="$XDG_CACHE_HOME"/poetry
	export POETRY_VIRTUALENVS_PATH="$XDG_DATA_HOME"/virtualenvs

	path_dirs_user+=("$POETRY_HOME/bin")

	export POETRY_HOME
fi

## Configure pyenv

PYENV_ROOT="$XDG_DATA_HOME"/pyenv
if [ -d "$PYENV_ROOT" ]; then
	path_dirs_user+=("$PYENV_ROOT/shims")

	function pyenv
    {
		eval "$(
            command pyenv init - "$PROFILE_SHELL" | sed -n '/pyenv()/,/^}$/p'
        )"

		pyenv "$@"
	}

	export PYENV_ROOT
fi

export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython

## Configure pylint

export PYLINTHOME="$XDG_CACHE_HOME"/pylint

### python.zsh ends here
