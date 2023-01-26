#!/bin/bash
# sh.wrap - module system for bash

## # util.sh
##
## TE module for utility functions.
##

___shwrap_te_lib_error__get_errors "${BASH_SOURCE[0]}"

## ## `___shwrap_te_lib_util__array_to_regex`
##
## Convert an array to a regex alternative string.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_lib_util__array_to_regex [arr...]
## ```
##
## ### Parameters
##
## - `arr`
##   Array.
##
## ### Return
##
## Regex alternative string.
##
___shwrap_te_lib_util__array_to_regex()
{
	local arr=("$@")
	cat <(IFS='|'; echo -n "${arr[*]}" | sed -e 's/|/\\|/g')
}

## ## `___shwrap_te_lib_util__definition`
##
## Search a definition for a given identifier.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_lib_util__define id
## ```
##
## ### Parameters
##
## - `id`
##   Identifier.
##
## ### Exit status
##
## - `___STLE___SUCCESS` - success
## - `___STLU_D___ERROR_NO_DEFINITION_FOUND` - no definition found
##
## ### Return
##
## Definition.
##
___shwrap_te_lib_util__define()
{
	declare -g ___STLU_D___ERROR_NO_DEFINITION_FOUND=125

	local id="$1"

	local definition
	definition=$(set -o posix | set | grep "^${id}=" | sed -E 's/[^=]+=//')
	if [[ -n "${definition}" ]]; then
		echo -n "${definition}"
		return ${___STLE___SUCCESS}
	fi

	return ${___STLU_D___ERROR_NO_DEFINITION_FOUND}
}

## ## `___shwrap_te_lib_util__caller_filename`
##
## Get a caller filename for the current execution context.
##
## ### Return
##
## Caller filename.
##
___shwrap_te_lib_util__caller_filename()
{
	caller 1 | cut -d ' ' -f 3
}

## ## `___shwrap_te_lib_util__check_function`
##
## Check if `name` is a defined function name.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_lib_util__check_function name
## ```
##
## ### Parameters
##
## - `name`
##   Function name.
##
## ### Exit status
##
## - `___STLE___SUCCESS` - success
## - `___STLE___ERROR` - otherwise
##
___shwrap_te_lib_util__check_function()
{
	local name="$1"

	if declare -F | grep -q "^${name}$"; then
		return ${___STLE___SUCCESS}
	fi
	return ${___STLE___ERROR}
}
