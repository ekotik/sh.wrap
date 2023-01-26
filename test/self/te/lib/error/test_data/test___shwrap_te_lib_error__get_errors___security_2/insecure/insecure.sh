___shwrap_te_lib_error__get_errors()
{
	declare -g ___STLE__GE___ERROR_NO_FILE=125

	local file="$1"
	local pattern="$2"

	local ___STLE___PATTERN='___STL.*___ERROR.*=[0-9]\+'
	pattern="${pattern:-"${___STLE___PATTERN}"}"
	if [[ -f "${file}" ]]; then
		local errors=$(grep -e "${pattern}" "${file}")
		errors=$(
			# sed escaping bypass
			echo -e "${errors}" |
				sed -e "s/.*declare -g \(.*\)=\(.*\)/declare -g '\1'='\2'/")
		eval "${errors}"
	else
		return ${___STLE__GE___ERROR_NO_FILE}
	fi
}
