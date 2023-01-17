___STLE___PATTERN="SHWRAP_TEST_DATA___EXPLOIT"

___shwrap_te_lib_error__get_errors()
{
	declare -g ___STLE__GE___ERROR_NO_FILE=125
	declare -g ___STLE__GE___ERROR_EVAL_FAILED=124

	local file="$1"
	local pattern="$2"
	pattern="${pattern:-"${___STLE___PATTERN}"}"

	if [[ -f "${file}" ]]; then
		local errors=$(grep -e "${pattern}" "${file}")
		errors=$(
			# sed bypass
			# no check for something that not declare -g
			echo "${errors}" |
				sed -e "s/.*declare -g \(.*\)=\(.*\)/declare -g '\1'='\2'/")
		if ! eval "${errors}"; then
			return ${___STLE__GE___ERROR_EVAL_FAILED}
		fi
	else
		return ${___STLE__GE___ERROR_NO_FILE}
	fi

	return ${___STLE__SUCCESS}
}
