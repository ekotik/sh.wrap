#!/bin/bash
# sh.wrap - module system for bash

## # version.secure.spec.sh
##
## Test cases to verify security of lib/version.sh TE core library module.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `test___shwrap_te_lib_version__versinfo_format___security_1`
##
## Check that a call to the library function is not vulnerable to a code
## injection.
##
test___shwrap_te_lib_version__versinfo_format___security_1()
{
	local stdout
	stdout=$(!(
				source "${SHWRAP_TEST_CASE_DATA}"/test___shwrap_te_lib_version__versinfo_format___security_1/insecure/exploit.sh
				___shwrap_te_lib_version__versinfo_format ''
			))
	[[ -z "${stdout}" ]]
}
