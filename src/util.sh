#!/bin/bash
# sh.wrap - module system for bash

## # util.sh
##
## Utility functions.
##

## ## `__shwrap_filter`
##
## Read and filter declared variables with reserved and shell specific variables
## removed.
##
## #### sh.wrap special variables
##
## All variables with `_shwrap_` or `_SHWRAP_` in a name.
##
## #### Special bash variables
##
## _ BASH BASHOPTS BASHPID BASH_ALIASES BASH_ARGC BASH_ARGV BASH_ARGV0 BASH_CMDS
## BASH_COMMAND BASH_COMPAT BASH_ENV BASH_EXECUTION_STRING BASH_LINENO
## BASH_LOADABLES_PATH BASH_REMATCH BASH_SOURCE BASH_SUBSHELL BASH_VERSINFO
## BASH_VERSION BASH_XTRACEFD
##
## #### Special environment variables
##
## CHILD_MAX COLUMNS COMP_CWORD COMP_LINE COMP_POINT COMP_TYPE COMP_KEY
## ~~COMP_WORDBREAKS~~ COMP_WORDS COMPREPLY COPROC DIRSTACK EMACS ENV
## EPOCHREALTIME EPOCHSECONDS EUID EXECIGNORE FCEDIT FIGNORE FUNCNAME FUNCNEST
## GLOBIGNORE GROUPS histchars HISTCMD HISTCONTROL HISTFILE HISTFILESIZE
## HISTIGNORE HISTSIZE HISTTIMEFORMAT HOSTFILE HOSTNAME HOSTTYPE IGNOREEOF
## INPUTRC INSIDE_EMACS LANG LC_ALL LC_COLLATE LC_CTYPE LC_MESSAGES LC_NUMERIC
## LC_TIME LINENO LINES MACHTYPE MAILCHECK MAPFILE OLDPWD OPTERR OSTYPE
## PIPESTATUS POSIXLY_CORRECT PPID PROMPT_COMMAND PROMPT_DIRTRIM PS0 PS3 PS4 PWD
## RANDOM READLINE_ARGUMENT READLINE_LINE READLINE_MARK READLINE_POINT REPLY
## SECONDS SHELL SHELLOPTS SHLVL SRANDOM TIMEFORMAT TMOUT TMPDIR UID
##
## ### Return
##
## Filtered variable declarations.
##
function __shwrap_filter()
{
	local __shwrap_prefix="^declare[[:space:]][-fFgIpaAilnrtux]\+[[:space:]]"
	local __shwrap_special='_\+shwrap_.*\|_\+SHWRAP_.*'
	local __shwrap_bash_special='_\|BASH\|BASHOPTS\|BASHPID\|BASH_ALIASES\|BASH_ARGC\|BASH_ARGV\|BASH_ARGV0\|BASH_CMDS\|BASH_COMMAND\|BASH_COMPAT\|BASH_ENV\|BASH_EXECUTION_STRING\|BASH_LINENO\|BASH_LOADABLES_PATH\|BASH_REMATCH\|BASH_SOURCE\|BASH_SUBSHELL\|BASH_VERSINFO\|BASH_VERSION\|BASH_XTRACEFD'
	local __shwrap_env_special='CHILD_MAX\|COLUMNS\|COMP_CWORD\|COMP_LINE\|COMP_POINT\|COMP_TYPE\|COMP_KEY\|COMP_WORDS\|COMPREPLY\|COPROC\|DIRSTACK\|EMACS\|ENV\|EPOCHREALTIME\|EPOCHSECONDS\|EUID\|EXECIGNORE\|FCEDIT\|FIGNORE\|FUNCNAME\|FUNCNEST\|GLOBIGNORE\|GROUPS\|histchars\|HISTCMD\|HISTCONTROL\|HISTFILE\|HISTFILESIZE\|HISTIGNORE\|HISTSIZE\|HISTTIMEFORMAT\|HOSTFILE\|HOSTNAME\|HOSTTYPE\|IGNOREEOF\|INPUTRC\|INSIDE_EMACS\|LANG\|LC_ALL\|LC_COLLATE\|LC_CTYPE\|LC_MESSAGES\|LC_NUMERIC\|LC_TIME\|LINENO\|LINES\|MACHTYPE\|MAILCHECK\|MAPFILE\|OLDPWD\|OPTERR\|OSTYPE\|PIPESTATUS\|POSIXLY_CORRECT\|PPID\|PROMPT_COMMAND\|PROMPT_DIRTRIM\|PS0\|PS3\|PS4\|PWD\|RANDOM\|READLINE_ARGUMENT\|READLINE_LINE\|READLINE_MARK\|READLINE_POINT\|REPLY\|SECONDS\|SHELL\|SHELLOPTS\|SHLVL\|SRANDOM\|TIMEFORMAT\|TMOUT\|TMPDIR\|UID'
	local __shwrap_suffix="=*"
	grep -v "${__shwrap_prefix}\(${__shwrap_special}\|${__shwrap_bash_special}\|${__shwrap_env_special}\)${__shwrap_suffix}"
}

## ## `__shwrap_declare`
##
## Read variable declarations and re-declare them as global.
##
## ### Return
##
## - Global variable declarations.
##
function __shwrap_declare()
{
	sed -e 's/^declare --/declare -g/' |
		sed -E 's/^declare -([^ -]+)/declare -\1g/'
}

## ## `__shwrap_scope`
##
## Read, filter and re-declare variables as global with reserved and shell
## specific variables removed.
##
## ### Return
##
## Global variable declarations.
##
function __shwrap_scope()
{
	declare -p | __shwrap_filter | __shwrap_declare
}

## ## `__shwrap_name_is_function`
##
## Check if `__shwrap_name` is a name of a declared function.
##
## ### Synopsis
##
## ```shell
## __shwrap_name_is_function __shwrap_name
## ```
##
## ### Parameters
##
## - `__shwrap_name` \
##   Function name.
##
## ### Exit status
##
## - `0` - success
## - `1` - otherwise
##
function __shwrap_name_is_function()
{
	local __shwrap_name="$1"
	declare -F "${__shwrap_name}" > /dev/null
}

## ## `__shwrap_log`
##
## Log `message` if `SHWRAP_MODULE_LOG` is not null.
##
## ### Synopsis
##
## ```shell
## __shwrap_log message
## ```
##
## ### Parameters
##
## - `message` \
##   Message.
##
## ### Return
##
## Message.
##
function __shwrap_log()
{
	local message="$*"
	{ [[ -n "${SHWRAP_MODULE_LOG}" ]] && echo "${message}"; } || true
}

## ## `__shwrap_random_bytes`
##
## Get `count` random bytes.
##
## ### Return
##
## Random bytes.
##
function __shwrap_random_bytes()
{
	local count="$1"
	dd if=/dev/urandom bs=1 count="${count}" 2>/dev/null
}

## ## `__shwrap_md5sum`
##
## Read input and calculate its md5 hash sum.
##
## ### Return
##
## md5 hash.
##
function __shwrap_md5sum()
{
	md5sum | cut -d $' ' -f1
}

## ## `__shwrap_fd_is_free`
##
## Checks if `fd` is a free file descriptor.
##
## ### Synopsis
##
## ```shell
## __shwrap_fd_is_free fd
## ```
##
## ### Parameters
##
## - `fd` \
##   File descriptor.
##
## ### Exit status
##
## - `0` - success
## - `1` - otherwise
##
function __shwrap_fd_is_free()
{
	local fd="$1"
	if [[ -e /proc/"$$"/fd/"${fd}" ]]; then
		return 1
	fi
	return 0
}

## ## `__shwrap_get_fd`
##
## Call function stored in `SHWRAP_FD_FUNC` with given parameters. \
## Expected that `fdr_start` and `fdr_end` are valid.
##
## ### Synopsis
##
## ```shell
## __shwrap_get_fd fdr_start fdr_end
## ```
##
## ### Parameters
##
## - `fdr_start` \
##   Start of a file descriptors range.
## - `fdr_end` \
##   End of a file descriptors range.
##
## ### Return
##
## Message.
##
function __shwrap_get_fd()
{
	local fdr_start="$1"
	local fdr_end="$2"

	eval "${SHWRAP_FD_FUNC}" "${fdr_start}" "${fdr_end}"
}

## ## `__shwrap_get_fd_random`
##
## Get a random free file descriptor from the range between `fdr_start` and
## `fdr_end` in a maximum of `SHWRAP_FD_RANDOM_MAXTRY` tries.
##
## ### Synopsis
##
## ```shell
## __shwrap_get_fd_random fdr_start fdr_end
## ```
##
## ### Parameters
##
## - `fdr_start` \
##   Start of a file descriptors range.
## - `fdr_end` \
##   End of a file descriptors range.
##
## ### Return
##
## - `fd` - if founded
## - `-1` - otherwise
##
function __shwrap_get_fd_random()
{
	local fdr_start="$1"
	local fdr_end="$2"
	local fdr_size=$(("${fdr_end}" - "${fdr_start}"))
	local __fd fd=-1
	local try=0 maxtry="${SHWRAP_FD_RANDOM_MAXTRY}"
	while [[ "$((try++))" -lt "${maxtry}" ]]; do
		__fd=$(("${RANDOM}" % "${fdr_size}" + "${fdr_start}"))
		if __shwrap_fd_is_free "${__fd}"; then
			fd="${__fd}"
			break
		fi
	done
	if [[ "${fd}" == -1 ]]; then
		__shwrap_log "__shwrap_get_fd: error: no free fd after '${maxtry}' tries" >&2
	fi
	echo "${fd}"
}

## ## `__shwrap_get_fd_sequential`
##
## Get a next free file descriptor from the range between `fdr_start` and
## `fdr_end`.
##
## ### Synopsis
##
## ```shell
## __shwrap_get_fd_sequential fdr_start fdr_end
## ```
##
## ### Parameters
##
## - `fdr_start` \
##   Start of a file descriptors range.
## - `fdr_end` \
##   End of a file descriptors range.
##
## ### Return
##
## - `fd` - if founded
## - `-1` - otherwise
##
function __shwrap_get_fd_sequential()
{
	local fdr_start="$1"
	local fdr_end="$2"
	local __fd fd=-1
	for __fd in $(seq "${fdr_start}" "${fdr_end}" | head -n -1); do
		if [[ -v _shwrap_fds["${__fd}"] ]]; then
			continue
		fi
		fd="${__fd}"
		break
	done
	if [[ "${fd}" == -1 ]]; then
		__shwrap_log "__shwrap_get_fd: error: no free fd between '${fdr_start}' and '${fdr_end}'" >&2
	fi
	echo "${fd}"
}
