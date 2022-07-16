#!/usr/bin/env zsh

export NVM_DIR="$XDG_DATA_HOME"/nvm
export NVM_SYMLINK_CURRENT=true

nvm_bin_paths=(
	nvm
	yarn
	"$NVM_DIR"/v0*/bin/*(N)
	"$NVM_DIR"/versions/*/*/bin/*(N)
)

for cmd (${(u)nvm_bins:t}); do
	eval "$(cat <<EOF
function $cmd
{
	unset -f $nvm_bins >/dev/null 2>&1
	source '$NVM_DIR/nvm.sh'
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

unset cmd nvm_bin_paths
