___shwrap_te_lib_suite__specific_define()
{
	local prefix="$1"
	[[ $# == 0 ]] || [[ -z "${prefix}" ]] &&
		return ${___STLE___ERROR}

	local specific_prefix="${___STLS___SPECIFIC_PREFIX}"
	local check
	for check in "${SHWRAP_TEST_SPECIFIC_SUITES[@]}"; do
		if ___shwrap_te_lib_suite__specific_check "${check}"; then
			local _test tests
			tests=$(declare -F |
						grep "${specific_prefix}""${prefix}"__"${check}")
			# define suites without specific prefix
			for _test in "${tests[@]}"; do
source <(cat <<EOF
${prefix}__${check}() {
	${specific_prefix}${prefix}__${check}
}
EOF
)
			done
		fi
	done

	return ${___STLE___SUCCESS}
}
