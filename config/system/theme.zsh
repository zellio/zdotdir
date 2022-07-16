#!/usr/bin/env zsh

function is_container
{
	is_installed systemd-detect-virt &&
		systemd-detect-virt --container --quiet
}

function is_ssh_shell
{
	test -n "$SSH_CLIENT" -o -n "$SSH_CONNECTION" -o -n "$SSH_TTY"
}

function is_virtual_machine
{
	is_installed systemd-detect-virt &&
		systemd-detect-virt --vm --quiet
}


typeset -Ax prompt_colours
case "$TERM" in
	*-256color)
		prompt_colours=(
			binder '%F{033}' user '%F{081}' host '%F{166}' path '%F{147}'
			git '%F{124}' metal '%f' container '%F{201}' vm '%F{226}'
			ssh '%F{081}'
		)
		;;

	*)
		prompt_colours=(
			binder '%B%F{004}' user '%B%F{006}' host '%F{005}' path '%F{002}'
			git '%F{005}' metal '%f' container '%F{005}' vm '%F{003}'
			ssh '%F{006}'
		)
		;;
esac

PROMPT="%{$prompt_colours[binder]%}(%{%f%}●"

if is_ssh_shell; then
	PROMPT+="%{$prompt_colours[ssh]%}●"
fi

if is_container; then
	PROMPT+="%{$prompt_colours[container]%}"
elif is_virtual_machine; then
	PROMPT+="%{$prompt_colours[vm]%}"
else
	PROMPT+="%{$prompt_colours[metal]%}"
fi

PROMPT+='●'
PROMPT+="%{$prompt_colours[binder]%}) "
PROMPT+="%{$prompt_colours[user]%}%n"
PROMPT+="%{$prompt_colours[binder]%}@"
PROMPT+="%{$prompt_colours[host]%}%m"
PROMPT+="%{$prompt_colours[binder]%}:"
PROMPT+="%{$prompt_colours[path]%}%~%{%f%} "

autoload -Uz vcs_info

function +vi-git-untracked
{
	if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = 'true' ] &&
		   [ "$(git ls-files --others --exclude-standard | wc -l)" -ne 0 ]; then
		hook_com[unstaged]+="%{%F{red}%}■%{%f%}"
	fi
}

function +vi-git-status-cleanup
{
	if [ -n "$hook_com[unstaged]" ]; then
		hook_com[unstaged]+=' '
	elif [ -n "$hook_com[staged]" ]; then
		hook_com[staged]+=' '
	fi
}

function +vi-git-remote-status
{
	local ahead behing remote
	local -a git_status

	remote="${hook_com[branch]}@{upstream}"

	ahead="$(git rev-list "$remote"..HEAD 2>/dev/null | wc -l)"
	behind="$(git rev-list HEAD.."$remote" 2>/dev/null | wc -l)"

	(( ahead )) && git_status+=( "+$ahead" )
	(( behind )) && git_status+=( "-$behind" )

	(( $#git_status )) &&
		hook_com[misc]+=" %{%F{green}%}${(pj:/:)git_status}%{%f%}"
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%{%F{green}%}■%{%f%}"
zstyle ':vcs_info:git:*' unstagedstr "%{%F{yellow}%}■%{%f%}"
zstyle ':vcs_info:git:*' formats "%{$prompt_colours[binder]%}[%{$prompt_colours[host]%}± %c%u%{$prompt_colours[git]%}%b%m%{$prompt_colours[binder]%}]%{%f%} "
zstyle ':vcs_info:git:*' actionformats "%{$prompt_colours[binder]%}[%{$prompt_colours[host]%}± %c%u%{$prompt_colours[git]%}%b%{$prompt_colours[binder]%}:%{$prompt_colours[git]%}%a%{$prompt_colours[binder]%}]%{%f%} "
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-status-cleanup git-remote-status

function precmd
{
	vcs_info
}

PROMPT+="\${vcs_info_msg_0_}%{$prompt_colours[binder]%}%#%{%f%b%} "
export PROMPT
