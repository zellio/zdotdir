#!/use/bin/env ssh.zsh

PAGER=
if is_installed most; then
	PAGER='most'
elif is_installed less; then
	PAGER='less'
elif is_installed more;then
	PAGER='more'
else
	PAGER='cat'
fi

export PAGER
