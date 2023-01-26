#!/bin/bash
# sh.wrap - module system for bash

## # 01-settings.spec.sh
##
## Test cases to validate setting functionality since `0.0.1`.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh
source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh

## # `test_func_settings__shwrap_defaults`
##
## Check that default settings have expected values on default initialization.
##
test_func_settings__shwrap_defaults()
{
	___shwrap_te_common_init__init_default_src

	[[ "${SHWRAP_INIT_DIR}" == "${SHWRAP_SRC_ROOT}" ]]
	[[ "${SHWRAP_MODULE}" == "${SHWRAP_SRC_ROOT}"/module.sh ]]
	[[ "${SHWRAP_MODULE_PATH}" == ~/.sh.wrap ]]
	[[ "${SHWRAP_MODULE_PATHS[*]}" == "." ]]
	[[ "${SHWRAP_TMP_PATH}" == /tmp/sh.wrap ]]
	[[ "${SHWRAP_FD_RANGE[*]}" == "666 777" ]]
	[[ "${SHWRAP_FD_RANDOM_MAXTRY}" == "10" ]]
	[[ "${SHWRAP_FD_FUNC}" == "__shwrap_get_fd_sequential" ]]
}

## # `test_func_settings__shwrap_id`
##
## Check that SHWRAP_ID variable is set successfully.
##
test_func_settings__shwrap_id()
{
	local shwrap_id="0123456789"
	declare -g SHWRAP_ID="${shwrap_id}"
	local init_dir
	init_dir=$(realpath "${SHWRAP_SRC_ROOT}")
	___shwrap_te_common_init__init_default_src
	# shellcheck disable=SC2154
	# assigned in initialization
	local module_hash=${_shwrap_modules_hashes["${init_dir}"/module.sh]}
	[[ -f "${SHWRAP_TMP_PATH}"/"${shwrap_id}"_"${module_hash}"_cache.sh ]]
	[[ -f "${SHWRAP_TMP_PATH}"/"${shwrap_id}"_"${module_hash}"_run.sh ]]
}

## # `test_func_settings__shwrap_module`
##
## Check that SHWRAP_MODULE variable is set successfully.
##
test_func_settings__shwrap_module()
{
	local init_dir
	init_dir=$(realpath "${SHWRAP_SRC_ROOT}")
	local shwrap_module="${SHWRAP_TEST_CASE_DATA}"/_common/fd_pool/src/module.sh
	declare -g SHWRAP_MODULE="${shwrap_module}"
	___shwrap_te_common_init__init_default_src
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_settings__shwrap_module/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="__shwrap_test_data__get_fd_pool B __shwrap_test_data__get_fd_pool A A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_settings__shwrap_module_path_1`
##
## Check that default import from default path is successful in the case of
## `SHWRAP_MODULE_PATH` is set globally.
##
test_func_settings__shwrap_module_path_1()
{
	local shwrap_module_path
	shwrap_module_path=$(realpath "${SHWRAP_TEST_CASE_DATA}"/_common)
	declare -g SHWRAP_MODULE_PATH="${shwrap_module_path}"
	___shwrap_te_common_init__init_default_src
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_settings__shwrap_module_path_1/a/a.sh
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="B A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_settings__shwrap_module_path_2`
##
## Check that default import from default path is successful in the case of
## `SHWRAP_MODULE_PATH` is set in module.
##
test_func_settings__shwrap_module_path_2()
{
	___shwrap_te_common_init__init_default_src
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_settings__shwrap_module_path_2/a/a.sh
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="B A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_settings__shwrap_module_paths_1`
##
## Check that default import from user paths is successful in the case
## `SHWRAP_MODULE_PATHS` is set globally.
##
test_func_settings__shwrap_module_paths_1()
{
	local shwrap_module_path
	shwrap_module_path=$(realpath "${SHWRAP_TEST_CASE_DATA}"/_common)
	declare -ag SHWRAP_MODULE_PATHS=(
		"$(realpath "${SHWRAP_TEST_CASE_DATA}"/_common)"
	)
	___shwrap_te_common_init__init_default_src
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_settings__shwrap_module_paths_1/a/a.sh
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="B A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_settings__shwrap_module_paths_2`
##
## Check that default import from user paths is successful in modules
## `SHWRAP_MODULE_PATHS` is set in module.
##
test_func_settings__shwrap_module_paths_2()
{
	___shwrap_te_common_init__init_default_src
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_settings__shwrap_module_paths_2/a/a.sh
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="B A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_settings__shwrap_tmp_path`
##
## Check that SHWRAP_TMP_PATH variable is set successfully.
##
test_func_settings__shwrap_tmp_path()
{
	local shwrap_tmp_path="${SHWRAP_TEST_CASE_DATA}"/_tmp
	declare -g SHWRAP_TMP_PATH="${shwrap_tmp_path}"
	local init_dir
	init_dir=$(realpath "${SHWRAP_SRC_ROOT}")
	___shwrap_te_common_init__init_default_src
	local module_hash=${_shwrap_modules_hashes["${init_dir}"/module.sh]}
	[[ -f "${shwrap_tmp_path}"/"${SHWRAP_ID}"_"${module_hash}"_cache.sh ]]
	[[ -f "${shwrap_tmp_path}"/"${SHWRAP_ID}"_"${module_hash}"_run.sh ]]
}

## # `test_func_settings__shwrap_fd_func_1`
##
## Check that SHWRAP_FD_FUNC variable is set successfully.
##
test_func_settings__shwrap_fd_func_1()
{
	local init_dir
	init_dir=$(realpath "${SHWRAP_SRC_ROOT}")
	declare -g SHWRAP_FD_FUNC=__shwrap_get_fd_random
	declare -g SHWRAP_FD_RANGE=(10 14)
	declare -g SHWRAP_FD_RANDOM_MAXTRY=100
	___shwrap_te_common_init__init_default_src
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_settings__shwrap_fd_func_1/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="10 11 12 13 __shwrap_get_fd_random {10 14} 100 B __shwrap_get_fd_random {10 14} 100 A A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_settings__shwrap_fd_func_2`
##
## Check that SHWRAP_FD_FUNC variable is set successfully in modules.
##
test_func_settings__shwrap_fd_func_2()
{
	local init_dir
	init_dir=$(realpath "${SHWRAP_SRC_ROOT}")
	___shwrap_te_common_init__init_default_src
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_settings__shwrap_fd_func_2/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="C [20 21 30 31 666 667] B [30 31 666 667] B [666 667] A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}
