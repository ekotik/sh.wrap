#!/bin/bash
# sh.wrap - module system for bash
# util.sh
# Utility functions.

function __shwrap_scope()
{
	declare -p | grep -vE '_+shwrap_.*|BASHOPTS|BASH_ARGC|BASH_ARGV|BASH_LINENO|BASH_SOURCE|BASH_VERSINFO|EUID|FUNCNAME|GROUPS|PPID|SHELLOPTS|UID' | __shwrap_declare
}

function __shwrap_declare()
{
	sed -e 's/declare --/declare -g/' |
		sed -E 's/declare -([^ -]+)/declare -\1g/'
}

function __shwrap_name_is_function()
{
	local name="$1"
	declare -F "${name}" > /dev/null
}

function __shwrap_log()
{
	local message="$*"
	[[ -n "${_MODULE_LOG}" ]] && echo "${message}"
}
