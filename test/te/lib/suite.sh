#!/bin/bash
# sh.wrap - module system for bash

## # suite.sh
##
## TE module for utility functions.
##

___shwrap_te_lib_error__get_errors "${BASH_SOURCE[0]}"

declare -g ___STLS___SPECIFIC_PREFIX="_"
declare -g ___STLS___SPECIFIC_DELIMITER="___"
declare -g ___STLS___SPECIFIC_CHECK_PREFIX="___STLS___"
declare -g ___STLS___SPECIFIC_CHECK_SUFFIX="_CHECK"

## ## `___shwrap_te_lib_suite__specific_check`
##
## Confirm if a given suite check is applied to the specific execution
## environment.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_lib_suite__specific_check check
## ```
##
## ### Parameters
##
## - `check`
##   Specific check identifier. \
##   Should be uppercase in actual check function name.
##
## ### Environment
##
## - `___STLS___SPECIFIC_CHECK_PREFIX`
##   Default check function prefix.
## - `___STLS___SPECIFIC_CHECK_SUFFIX`
##   Default check function suffix.
##
## ### Exit status
##
## - `___STLE___SUCCESS` - success
## - `___STLS__SC___ERROR_NOT_SPECIFIC` - check not specific
## - `___STLV__SC___ERROR_NO_CHECK` - check doesn't exist
## - `___STLE___ERROR` - otherwise
##
___shwrap_te_lib_suite__specific_check()
{
	declare -g ___STLS__SC___ERROR_NOT_SPECIFIC=125
	declare -g ___STLS__SC___ERROR_NO_CHECK=124

	local check="$1"
	[[ $# == 0 ]] || [[ -z "${check}" ]] &&
		return ${___STLE___ERROR}

	local _prefix="${___STLS___SPECIFIC_CHECK_PREFIX}"
	local _suffix="${___STLS___SPECIFIC_CHECK_SUFFIX}"
	if "${_prefix}""${check^^}""${_suffix}"; then
		return ${___STLE___SUCCESS}
	else
		if [[ 127 == $? ]]; then
			return ${___STLS__SC___ERROR_NO_CHECK}
		else
			return ${___STLS__SC___ERROR_NOT_SPECIFIC}
		fi
	fi

	return ${___STLE___ERROR}
}

## ## `___shwrap_te_lib_suite__specific_define`
##
## Search and define specific tests with a given prefix if a specific execution
## environment is applied.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_lib_suite__specific_define prefix
## ```
##
## ### Parameters
##
## - `prefix`
##   Prefix for a suite.
##
## ### Environment
##
## - `SHWRAP_TEST_SPECIFIC_SUITES`
##   Specific execution environments.
## - `___STLS___SPECIFIC_PREFIX`
##   Specific prefix.
##
## ### Exit status
##
## - `___STLE___SUCCESS` - success
## - `___STLE___ERROR` - otherwise
##
___shwrap_te_lib_suite__specific_define()
{
	local prefix="$1"
	[[ $# == 0 ]] || [[ -z "${prefix}" ]] &&
		return ${___STLE___ERROR}

	local _prefix="${___STLS___SPECIFIC_PREFIX}"
	local delimiter="${___STLS___SPECIFIC_DELIMITER}"
	local check
	for check in "${SHWRAP_TEST_SPECIFIC_SUITES[@]}"; do
		if ___shwrap_te_lib_suite__specific_check "${check}"; then
			declare -a tests
			tests=($(declare -F |
						grep "${_prefix}""${prefix}""${delimiter}""${check}" |
						true))
			# define suites without specific prefix
			local _test
			for _test in "${tests[@]}"; do
			echo 111 $_test
source <(cat <<EOF
${prefix}${delimiter}${check}() {
	${_prefix}${prefix}${delimiter}${check}
}
EOF
)
			done
		fi
	done

	return ${___STLE___SUCCESS}
}

## ## `___shwrap_te_lib_suite__specific_run`
##
## Search and run specific tests with a given prefix if a specific execution
## environment is applied.
##
## ### Synopsis
##
## ```shell
## ___shwrap_te_lib_suite__specific_run prefix
## ```
##
## ### Parameters
##
## - `prefix`
##   Prefix for a suite.
##
## ### Environment
##
## - `SHWRAP_TEST_SPECIFIC_SUITES`
##   Specific execution environments.
##
## ### Exit status
##
## - `___STLE___SUCCESS` - success
## - `___STLE___ERROR` - otherwise
##
___shwrap_te_lib_suite__specific_run()
{
	local prefix="$1"
	[[ $# == 0 ]] || [[ -z "${prefix}" ]] &&
		return ${___STLE___ERROR}

	local delimiter="${___STLS___SPECIFIC_DELIMITER}"
	local check
	for check in "${SHWRAP_TEST_SPECIFIC_SUITES[@]}"; do
		if ___shwrap_te_lib_suite__specific_check "${check}"; then
			local _test tests
			tests=$(declare -F | grep "${prefix}""${delimiter}""${check}")
			# run specific suites
			for _test in "${tests[@]}"; do
				"${prefix}""${delimiter}""${check}"
			done
		fi
	done

	return ${___STLE___SUCCESS}
}

## ## `___STLS___BASH_EQ_44_CHECK`
##
## Check if a version of bash = 4.4.
##
## ### Environment
##
## - `BASH_VERSINFO`
##   Bash version information.
##
## ### Exit status
##
## - `0` - success
## - `1` - otherwise
##
___STLS___BASH_EQ_44_CHECK()
{
	local version
	version=$(___shwrap_te_lib_version__versinfo_format BASH_VERSINFO minor)
	[[ "${version}" -eq 44 ]]
}

___STLS___BASH_EQ_44_OR_52_CHECK()
{
	local version
	version=$(___shwrap_te_lib_version__versinfo_format BASH_VERSINFO minor)
	[[ "${version}" -eq 44 ]] || [[ "${version}" -eq 52 ]]
}

___STLS___BASH_AND_GDB_CHECK()
{
	{ which bash && which gdb; } > /dev/null
}
