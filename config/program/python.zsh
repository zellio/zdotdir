#!/usr/bin/env zsh

is_installed pyenv || is_installed python || return

export PYTHONPATH='.'
export PYTHONUTF8='1'
export PYTHONPYCACHEPREFIX="${PYTHONPYCACHEPREFIX:-$XDG_CACHE_HOME/python}"
export PYTHONSTARTUP="${PYTHONSTARTUP:-$XDG_CONFIG_HOME/python/pythonrc}"

if [ ! -d "$PYTHONPYCACHEPREFIX" ]; then
	mkdir -p "${PYTHONPYCACHEPREFIX}"
fi

### Configure poetry

POETRY_HOME="$XDG_DATA_HOME"/poetry
if [ -d "$POETRY_HOME" ]; then
	path_prepend+=("$POETRY_HOME/bin")
fi

### Configure pyenv

PYENV_ROOT="$XDG_DATA_HOME"/pyenv
if [ -d "$PYENV_ROOT" ]; then
	path_prepend+=(
		"$(pyenv init --path | awk -F'[":]' '/export PATH=/{print $2}')"
	)

	function pyenv {
		eval "$(command pyenv init - "$PROFILE_SHELL" | tail -n+3)"
		pyenv "$@"
	}

	export PYENV_ROOT
fi

export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"

### Configure pylint

export PYLINTHOME="${XDG_CACHE_HOME}"/pylint
