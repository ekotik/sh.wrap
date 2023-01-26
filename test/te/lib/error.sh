#!/bin/bash
# sh.wrap - module system for bash

## # error.sh
##
## TE core module for error checking.
##

declare -g ___STLE___SUCCESS=0
declare -g ___STLE___ERROR=1

declare -g ___STLE___PATTERN='___STL.*___ERROR.*=[0-9]\+'

## ## `___shwrap_te_lib_error__get_errors`
##
## Parse and declare error codes of a given pattern from a source file.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_lib_error__get_errors file [pattern]
## ```
##
## ### Parameters
##
## - `file`
##   Source file.
##
## - `pattern`
##   Patter for error codes. Default is `___STLE___PATTERN`.
##
## ### Environment
##
## - `___STLE___PATTERN`
##   Default pattern.
##
## ### Exit status
##
## - `___STLE___SUCCESS` - success
## - `___STLE__GE___ERROR_NO_FILE` - no such file
## - `___STLE__GE___ERROR_EVAL_FAILED` - eval failed
##
___shwrap_te_lib_error__get_errors()
{
	declare -g ___STLE__GE___ERROR_NO_FILE=125
	declare -g ___STLE__GE___ERROR_EVAL_FAILED=124

	local file="$1"
	local pattern="$2"
	pattern="${pattern:-"${___STLE___PATTERN}"}"
	local guard_pattern='^[[:space:]]*declare[[:space:]]-g[[:space:]]\(.*\)='
	local escape_pattern="s/${guard_pattern}\(.*\)$/declare -g '\1'='\2'/"
	if [[ -f "${file}" ]]; then
		local errors
		if errors=$(set -o pipefail; grep -e "${pattern}" "${file}" |
						grep "${guard_pattern}" |
						sed -e "${escape_pattern}"); then
			if ! eval "${errors}"; then
				return ${___STLE__GE___ERROR_EVAL_FAILED}
			fi
		fi
	else
		return ${___STLE__GE___ERROR_NO_FILE}
	fi

	return ${___STLE___SUCCESS}
}

___shwrap_te_lib_error__get_errors "${BASH_SOURCE[0]}"
