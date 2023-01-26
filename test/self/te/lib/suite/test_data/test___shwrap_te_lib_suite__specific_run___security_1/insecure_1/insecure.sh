___shwrap_te_lib_suite__specific_run()
{
	local prefix="$1"
	[[ $# == 0 ]] || [[ -z "${prefix}" ]] &&
		return ${___STLE___ERROR}

	local check
	for check in "${SHWRAP_TEST_SPECIFIC_SUITES[@]}"; do
		if ___shwrap_te_lib_suite__specific_check "${check}"; then
			# no check before eval
			eval "${prefix}___${check}"
		fi
	done

	return ${___STLE___SUCCESS}
}
