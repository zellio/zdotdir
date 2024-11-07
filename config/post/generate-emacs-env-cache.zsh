#!/usr/bin/env zsh

declare EMACS_CONFIG_HOME="$XDG_CONFIG_HOME"/emacs
declare CACHE_FILE="$EMACS_CONFIG_HOME"/etc/shell-environment.el

[ -r "$CACHE_FILE" ] && rm -- "$CACHE_FILE"

cat <<'EOF' >"$CACHE_FILE"
(user/load-environment
 '(
EOF

for env in $(declare -x | grep '^[A-Z]' | cut -d= -f1); do
    printf '   ("%s" . "%s")\n' "$env" "${(P)env}" >>"$CACHE_FILE"
done

cat <<'EOF' >>"$CACHE_FILE"
))
EOF

unset env EMACS_CONFIG_HOME CACHE_FILE
