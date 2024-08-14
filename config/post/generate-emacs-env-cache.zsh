#!/usr/bin/env zsh

EMACS_CONFIG_HOME="$XDG_CONFIG_HOME"/emacs/config
CONFIG_FILE="$EMACS_CONFIG_HOME"/01_generated-environment.el

[ -r "$CONFIG_FILE" ] && rm -- "$CONFIG_FILE"

cat <<'EOF' >"$CONFIG_FILE"
(user/load-environment
 '(
EOF

for env in $(declare -x | grep '^[A-Z]' | cut -d= -f1); do
    printf '   ("%s" . "%s")\n' "$env" "${(P)env}" >>"$CONFIG_FILE"
done

cat <<'EOF' >>"$CONFIG_FILE"
))
EOF

unset env EMACS_CONFIG_HOME CONFIG_FILE
