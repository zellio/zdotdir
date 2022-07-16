#!/usr/bin/env zsh

export NVM_DIR="$XDG_DATA_HOME"/nvm
export NVM_SYMLINK_CURRENT=true
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history

nvm_bin_paths=(
	nvm
	yarn
	"$NVM_DIR"/v0*/bin/*(N)
	"$NVM_DIR"/versions/*/*/bin/*(N)
)

nvm_bins=(${(u)nvm_bin_paths:t})

for cmd ($nvm_bins); do
	eval "$(cat <<EOF
function $cmd
{
	unset npm_config_cache npm_config_init_module npm_config_prefix npm_config_tmp npm_config_userconfig
	unset -f $nvm_bins >/dev/null 2>&1
	source '/Users/zellio/.local/share/nvm/nvm.sh'
	cd "\$(pwd)"
	$cmd "\$@"
}
EOF
)"
done

export npm_config_cache="$XDG_CACHE_HOME"/npm
export npm_config_init_module="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export npm_config_prefix="$XDG_DATA_HOME"/npm
export npm_config_tmp="$XDG_RUNTIME_DIR"/npm
export npm_config_userconfig="$XDG_CONFIG_HOME"/npmrc

unset cmd nvm_bin_paths nvm_bins
