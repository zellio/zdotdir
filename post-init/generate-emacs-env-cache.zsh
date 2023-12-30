#!/usr/bin/env zsh

cat <<'EOF' >"$XDG_CONFIG_HOME"/emacs/config/00_generated-env.el
(mapc
 (lambda (pair)
   (let ((name (car pair))
		 (value (cdr pair)))
	 (setenv name value)
	 (when (string-equal name "PATH")
       (setq
		exec-path (append (parse-colon-path value) (list exec-directory)))
	   (setq-default
		eshell-path-env value))))
 '(
EOF

for env in $(declare -x | grep '^[A-Z]' | cut -d= -f1); do
    printf '   ("%s" . "%s")\n' "$env" "${(P)env}" >>"$XDG_CONFIG_HOME"/emacs/config/00_generated-env.el
done

cat <<'EOF' >>"$XDG_CONFIG_HOME"/emacs/config/00_generated-env.el
))
EOF
