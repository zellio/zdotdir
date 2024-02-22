#!/usr/bin/env zsh

CONFIG_FILE="$XDG_CONFIG_HOME"/emacs/config/01_generated-environment.el

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

unset env CONFIG_FILE
