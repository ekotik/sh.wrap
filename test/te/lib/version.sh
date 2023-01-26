#!/bin/bash
# sh.wrap - module system for bash

## # version.sh
##
## TE module for version functions.
##

___shwrap_te_lib_error__get_errors "${BASH_SOURCE[0]}"

## ## `___shwrap_te_lib_version__versinfo_format`
##
## Convert version array to a version string with a maximum version `level` and
## a `delimiter`.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_lib_version__versinfo_format versinfo [level] [delimiter]
## ```
##
## ### Parameters
##
## - `versinfo`
##   Version array identifier.
##
## - `level`
##   Version level. \
##   Values: `major`|`minor`|`patch`. Default is `patch`.
##
## - `delimiter`
##   Delimiter. Default is `$''`.
##
## ### Exit status
##
## - `___STLE___SUCCESS` - success
## - `___STLV__VF___ERROR_NO_VERSINFO` - no `versinfo` argument
## - `___STLV__VF___ERROR_NO_DEFINITION_FOUND` - no definition found
## - `___STLV__VF___ERROR_INVALID_VERSINFO` - invalid versinfo definition
## - `___STLV__VF___ERROR_LEVEL_NOT_SUPPORTED` - level not supported
##
## ### Return
##
## Version string.
##
___shwrap_te_lib_version__versinfo_format()
{
	declare -g ___STLV__VF___ERROR_NO_VERSINFO=125
	declare -g ___STLV__VF___ERROR_NO_DEFINITION_FOUND=124
	declare -g ___STLV__VF___ERROR_INVALID_VERSINFO=123
	declare -g ___STLV__VF___ERROR_LEVEL_NOT_SUPPORTED=122

	local versinfo="$1"
	local level="$2"
	local delimiter="$3"

	[[ $# == 0 ]] && return ${___STLV__VF___ERROR_NO_VERSINFO}

	local _level
	local _n=0
	for _level in major minor patch; do
		((++_n))
		[[ "${level}" == "${_level}" ]] && break
	done
	if [[ -n "${level}" ]] && [[ "${level}" != patch ]] &&
		   [[ "${_n}" == 3 ]]; then
		return ${___STLV__VF___ERROR_LEVEL_NOT_SUPPORTED}
	fi
	local _versinfo
	if _versinfo=$(___shwrap_te_lib_util__define "${versinfo}"); then
		eval declare -a _versinfo='${_versinfo}'
		if [[ ${#_versinfo[@]} -ge 3 ]]; then
			printf '%s ' "${_versinfo[@]: 0:${_n}}" | xargs |
				sed -e "s/ /${delimiter}/g"
		else
			return ${___STLV__VF___ERROR_INVALID_VERSINFO_FORMAT}
		fi
	else
		if [[ ${___STLU_D___ERROR_NO_DEFINITION_FOUND} == $? ]]; then
			return ${___STLV__VF___ERROR_NO_DEFINITION_FOUND}
		fi
	fi

	return ${___STLE___SUCCESS}
}
