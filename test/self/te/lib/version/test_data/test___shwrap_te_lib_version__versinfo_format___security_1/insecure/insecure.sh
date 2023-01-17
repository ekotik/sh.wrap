___shwrap_te_lib_version__versinfo_format()
{
	declare -g ___STLV__VF___ERROR_NO_VERSINFO=125
	declare -g ___STLV__VF___ERROR_NO_DEFINITION_FOUND=124
	declare -g ___STLV__VF___ERROR_INVALID_VERSINFO=123

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
	local _versinfo
	if _versinfo=$(___shwrap_te_lib_util__define "${versinfo}"); then
		eval declare -a _versinfo="${_versinfo}"
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

	return ${___STL___SUCCESS}
}
