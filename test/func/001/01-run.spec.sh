#!/bin/bash
# sh.wrap - module system for bash

## # 01-run.spec.sh
##
## Test cases to validate run functionality since `0.0.1`.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh
source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## # `setup`
##
## Test cases setup.
##
setup()
{
	___shwrap_te_common_init__init_default_src
	local module="${SHWRAP_INIT_DIR}"/module.sh
	shwrap_import "${module}"
}

## # `test_func_run__simple_command`
##
## Check that a simple command runs as expected.
##
test_func_run__simple_command()
{
	local module="${SHWRAP_INIT_DIR}"/module.sh
	local expected_stdout="Hello, world!"
	local command="echo -n '${expected_stdout}'"
	local stdout
	stdout=$(shwrap_run "${module}" "${command}")
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_run__simple_command_args`
##
## Check that a simple command with arguments runs as expected.
##
test_func_run__simple_command_args()
{
	local module="${SHWRAP_INIT_DIR}"/module.sh
	local expected_stdout="Hello, world!"
	local command="echo -n"
	local stdout
	stdout=$(shwrap_run "${module}" "${command}" "${expected_stdout}")
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_run__compound_command`
##
## Check that a compound command runs as expected.
##
test_func_run__compound_command()
{
	local module="${SHWRAP_INIT_DIR}"/module.sh
	local input="Hello, world!"
	local command="[[ '${input}' == '${input}' ]] <<<"
	local stdout
	local expected_stdout="true"
}

## # `test_func_run__list_command`
##
## Check that a list command runs as expected.
##
test_func_run__list_command()
{
	local module="${SHWRAP_INIT_DIR}"/module.sh
	local input="Hello, world!"
	local command="{ [[ '${input}' == '${input}' ]] && echo true; } <<<"
	local stdout
	local expected_stdout="true"
	stdout=$(shwrap_run "${module}" "${command}")
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_run__pipeline_command`
##
## Check that a pipeline command runs as expected.
##
test_func_run__pipeline_command()
{
	local module="${SHWRAP_INIT_DIR}"/module.sh
	local input="Hello, world!"
	local command="{ echo -n '${input}' | sed -e 's/Hello/Good bye/'; } <<<"
	local stdout
	local expected_stdout="Good bye, world!"
	stdout=$(shwrap_run "${module}" "${command}")
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_run__pipeline_stdin_command`
##
## Check that a command takes stdin through the pipe as expected.
##
test_func_run__pipeline_stdin_command()
{
	local module="${SHWRAP_INIT_DIR}"/module.sh
	local expected_stdout="Hello, world!"
	local command="cat"
	local stdout
	stdout=$(echo "${expected_stdout}" | shwrap_run "${module}" "${command}")
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_run__pipeline_stdin_command`
##
## Check that a command gives stdout through the pipe as expected.
##
test_func_run__pipeline_stdout_command()
{
	local module="${SHWRAP_INIT_DIR}"/module.sh
	local input="Hello, world!"
	local command="cat"
	local command="echo -n '${input}'"
	local stdout
	local expected_stdout="Good bye, world!"
	stdout=$(shwrap_run "${module}" "${command}" | sed -e 's/Hello/Good bye/')
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_run__redirection`
##
## Check that a command with redirection runs as expected.
##
test_func_run__redirection()
{
	local module="${SHWRAP_INIT_DIR}"/module.sh
	local expected_stdout="Hello, world!"
	local command="{ echo -n '${expected_stdout}' >&20; } <<<"
	local stdout
	stdout=$(shwrap_run "${module}" "${command}" 20>&1)
	[[ "${stdout}" == "${expected_stdout}" ]]
}
