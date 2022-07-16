#!/usr/bin/evn zsh

is_installed brew || return

export HOMEBREW_NO_ENV_HINTS=1

### Handle Mac Arm BS

HOMEBREW_DIR=''
case "$MACHINE-$OSTYPE" in
	arm*-darwin*)
		HOMEBREW_DIR=/opt/homebrew
		;;

	*)
		HOMEBREW_DIR=/usr/local
		;;
esac

path_dirs_system=(
    "${HOMEBREW_DIR}"/bin "${HOMEBREW_DIR}"/sbin $path_dirs_system
)

### Update function paths

fpath=(
	"$HOMEBREW_DIR/share/zsh/site-functions"/***/(-/)
	$fpath
)

for func ( "$HOMEBREW_DIR/share/zsh/site-functions"/***/*(.N) ); do
	autoload "$func:t"
done

### Aliases

alias htop="sudo htop"
alias mtr="sudo mtr"

### Update paths

path_dirs_program=(
	$path_dirs_program "${HOMEBREW_DIR}/opt/"*/libexec/gnubin
)

keg_programs=(
	'bison'
	'bzip2'
	'curl'
	'flex'
	'ghostscript'
	'gnu-getopt'
	'icu4c'
	'krb5'
	'libffi'
	'llvm'
	'm4'
	'ncurses'
	'openjdk'
	'openldap'
	'postgresql@12'
	'readline'
	'ruby'
	'sqlite'
	'tcl-tk'
	'zlib'
)

typeset -UT LDFLAGS='' ldflags ' '
typeset -UT CFLAGS='' cflags ' '
typeset -UT CPPFLAGS='' cppflags ' '
typeset -UT PKG_CONFIG_PATH='' pkg_config_path ':'

for program in $keg_programs; do
	bin_path="${HOMEBREW_DIR}/opt/${program}/bin"
	if [ -d "$bin_path" ]; then
		path_dirs_program=($path_dirs_program "$bin_path")
	fi

	ld_path="${HOMEBREW_DIR}/opt/${program}/lib"
	if [ -d "$ld_path" ]; then
		ldflags=($ldflags "-L$ld_path")
	fi

	cpp_flags_path="${HOMEBREW_DIR}/opt/${program}/include"
	if [ -d "$cpp_flags_path" ]; then
		cppflags=($cppflags "-I$cpp_flags_path")
	fi

	config_path="${HOMEBREW_DIR}/opt/${program}/lib/pkgconfig"
	if [ -d "$config_path" ]; then
		pkg_config_path=($pkg_config_path "$config_path")
	fi
done

unset keg_programs program bin_path ld_path cpp_flags_path config_path

export LDFLAGS
export CFLAG="$CPPFLAGS"
export CPPFLAGS
export PKG_CONFIG_PATH

### Homebrew specific program weirdness

# Guile
export GUILE_LOAD_PATH="${HOMEBREW_DIR}/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="${HOMEBREW_DIR}/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="${HOMEBREW_DIR}/lib/guile/3.0/extensions"
export GUILE_TLS_CERTIFICATE_DIRECTORY="${HOMEBREW_DIR}/etc/gnutls/"

# Golang
export GOROOT="${HOMEBREW_DIR}/opt/go/libexec"

# Java
export JAVA_HOME="${HOMEBREW_DIR}/opt/openjdk"

# Groovy
export GROOVY_HOME="${HOMEBREW_DIR}/opt/groovy/libexec"
typeset -UT GROOVY_CLASSPATH groovy_classpath ':'
export groovy_classpath=($GROOVY_HOME/lib/*.jar(.))
alias groovysh="$GROOVY_HOME/bin/groovysh --classpath $GROOVY_CLASSPATH"
