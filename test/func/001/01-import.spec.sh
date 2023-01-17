#!/bin/bash
# sh.wrap - module system for bash

## # 01-import.spec.sh
##
## Test cases to validate import functionality since `0.0.1`.
##

# shellcheck disable=SC1091

source "${SHWRAP_TEST_TE_ROOT}"/test_case.sh

## # `setup`
##
## Test cases setup.
##
setup()
{
	source "${SHWRAP_TEST_LIB_ROOT}"/init/init.sh
	___shwrap_te_common_init__init_default_src
}

## # `test_func_import__import_default`
##
## Check that default import is successful.
##
test_func_import__import_default()
{
	local stdout
	shwrap_import "${SHWRAP_TEST_CASE_DATA}"/_common/a_scope/a.sh
	stdout=$({
				declare -F shwrap_test_data__print
				declare -F shwrap_test_data__print_a
				declare -F shwrap_test_data__change_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="shwrap_test_data__print shwrap_test_data__print_a shwrap_test_data__change_a"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_names_1`
##
## Check that names import is successful in the case of on name is requested.
##
test_func_import__import_names_1()
{
	local stdout
	shwrap_import "${SHWRAP_TEST_CASE_DATA}"/_common/a_scope/a.sh \
				  shwrap_test_data__print
	stdout=$({
				declare -F shwrap_test_data__print
				! declare -F shwrap_test_data__print_a
				! declare -F shwrap_test_data__change_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="shwrap_test_data__print"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_names_2`
##
## Check that names import is successful in the case of several names are
## requested.
##
test_func_import__import_names_2()
{
	local stdout
	shwrap_import "${SHWRAP_TEST_CASE_DATA}"/_common/a_scope/a.sh \
				  shwrap_test_data__print_a \
				  shwrap_test_data__change_a
	stdout=$({
				! declare -F shwrap_test_data__print
				declare -F shwrap_test_data__print_a
				declare -F shwrap_test_data__change_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="shwrap_test_data__print_a shwrap_test_data__change_a"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_absolute`
##
## Check that default import from an absolute path is successful.
##
test_func_import__import_absolute()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/_common/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_relative`
##
## Check that default import from a relative path is successful.
##
test_func_import__import_relative()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DIR_REL}"/test_data/_common/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_relative_links`
##
## Check that default import from a relative path with symbolic links is
## successful.
##
test_func_import__import_relative_links()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DIR_REL}"/test_data/test_func_import__import_relative_links/a/b/b.sh
				shwrap_test_data__print_b
				shwrap_import "${SHWRAP_TEST_CASE_DIR_REL}"/test_data/test_func_import__import_relative_links/c/c.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="B A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_absolute_links`
##
## Check that default import from an absolute path with symbolic links is
## successful.
##
test_func_import__import_absolute_links()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_absolute_links/a/b/b.sh
				shwrap_test_data__print_b
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_absolute_links/c/c.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="B A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_cached_1`
##
## Check that module is cached successfully in the case of the second import.
##
test_func_import__import_cached_1()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_cached_1/a/a.sh
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_cached_1/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_cached_2`
##
## Check that module is cached successfully in the case of the second import
## from a dependent module.
##
test_func_import__import_cached_2()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_cached_2/a/a.sh
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_cached_2/b/b.sh
				shwrap_test_data__print_a
				shwrap_test_data__print_b
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A B A B"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__env_clean`
##
## Check that a module import doesn't polute caller environment.
##
test_func_import__env_clean()
{
	shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__env_clean/a/a.sh
	! [ -v SHWRAP_TEST_DATA__PRINT_A1 ]
	! [ -v SHWRAP_TEST_DATA__PRINT_A2 ]
	! [ -v SHWRAP_TEST_DATA__PRINT_A3 ]
}

## # `test_func_import__self_dependency`
##
## Check that a module imports itself successfully.
test_func_import__self_dependency()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__self_dependency/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__scope_1`
##
## Check that a module scope is updated as expected in the case of an import
## chain looks like below.
##            ┌─┐              ┌─┐
##            │a│              │.│
##            └┬┘              └┬┘
##            ┌┴┐   import a    │
##            │ │ <─────────────│
##            │ │               │
##  ╔═════════╧═╧═══════════╗   │
##  ║VAR="A"               ░║   │
##  ║print_a() {...}        ║   │
##  ║change_a() {VAR="$1"}  ║   │
##  ╚═══════════════════════╝   │
##             │   imported     │
##             │───────────────>│
##             │                │
##             │call change_a() │
##             │<───────────────│
##            ┌┴┐              ┌┴┐
##            │a│              │.│
##            └─┘              └─┘
##
test_func_import__scope_1()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_1/a/a.sh
				shwrap_test_data__print_a
				shwrap_test_data__change_a "."
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A->."
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__scope_2`
##
## Check that a module scope is updated as expected in the case of an import
## chain looks like below.
##
##            ┌─┐                     ┌─┐          ┌─┐
##            │a│                     │b│          │.│
##            └┬┘                     └┬┘          └┬┘
##             │                      ┌┴┐ import b  │
##             │                      │ │ <─────────│
##             │                      │ │           │
##            ┌┴┐      import a       │ │           │
##            │ │ <───────────────────│ │           │
##            │ │                     │ │           │
##  ╔═════════╧═╧═══════════╗         │ │           │
##  ║VAR="A"               ░║         │ │           │
##  ║print_a() {...}        ║         │ │           │
##  ║change_a() {VAR="$1"}  ║         │ │           │
##  ╚═════════╤═╤═══════════╝         │ │           │
##            │ │────┐                │ │           │
##            │ │    │ call change_a()│ │           │
##            │ │<───┘                │ │           │
##            └┬┘                     │ │           │
##             │      imported        │ │           │
##             │────────────────────> │ │           │
##             │                      │ │           │
##             │  call change_a()     │ │           │
##             │<──────────────────── │ │           │
##             │                      └┬┘           │
##             │                       │ imported   │
##             │                       │───────────>│
##             │                       │            │
##             │              import   │            │
##             │<─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│
##             │                       │            │
##             │            from cache │            │
##             │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│
##             │                       │            │
##             │          call print_a()            │
##             │<───────────────────────────────────│
##            ┌┴┐                     ┌┴┐          ┌┴┐
##            │a│                     │b│          │.│
##            └─┘                     └─┘          └─┘
##
test_func_import__scope_2()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_2/b/b.sh
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_2/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A->A A->A A->A->B A->A->B"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__scope_3`
##
## Check that a module scope is updated as expected in the case of an import
## chain looks like below.
##
##            ┌─┐                 ┌─┐          ┌─┐
##            │a│                 │b│          │.│
##            └┬┘                 └┬┘          └┬┘
##             │                  ┌┴┐ import b  │
##             │                  │ │ <─────────│
##             │                  │ │           │
##             │         ╔════════╧═╧══════════╗│
##             │         ║change_a_from_b() { ░║│
##             │         ║  change_a();        ║│
##             │         ║}                    ║│
##             │         ╚════════╤═╤══════════╝│
##            ┌┴┐    import a     │ │           │
##            │ │ <───────────────│ │           │
##            │ │                 │ │           │
##  ╔═════════╧═╧═══════════╗     │ │           │
##  ║VAR="A"               ░║     │ │           │
##  ║print_a() {...}        ║     │ │           │
##  ║change_a() {VAR="$1"}  ║     │ │           │
##  ╚═══════════════════════╝     │ │           │
##             │    imported      │ │           │
##             │─────────────────>│ │           │
##             │                  │ │           │
##             │change_a_from_b() │ │           │
##             │<─────────────────│ │           │
##             │                  │ │           │
##             │   change_a()     │ │           │
##             │<─────────────────│ │           │
##             │                  │ │           │
##             │    print_a()     │ │           │
##             │<─────────────────│ │           │
##             │                  └┬┘           │
##             │                   │  imported  │
##             │                   │ ───────────>
##            ┌┴┐                 ┌┴┐          ┌┴┐
##            │a│                 │b│          │.│
##            └─┘                 └─┘          └─┘
##
test_func_import__scope_3()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_3/a/a.sh
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_3/b/b.sh
				shwrap_test_data__print_a
				shwrap_test_data__change_a_from_b
				shwrap_test_data__print_a
				shwrap_test_data__change_a "."
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A->BB A->BB A->BB->BB A->BB->BB->."
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__scope_4`
##
## Check that a module scope is updated as expected in the case of an import
## chain looks like below.
##
##            ┌─┐          ┌─┐                ┌─┐
##            │a│          │b│                │.│
##            └┬┘          └┬┘                └┬┘
##            ┌┴┐           import b           │
##            │ │ <─────────────────────────────
##            │ │           │                  │
##  ╔═════════╧═╧═══════════╗                  │
##  ║VAR="A"               ░║                  │
##  ║print_a() {...}        ║                  │
##  ║change_a() {VAR="$1"}  ║                  │
##  ╚═══════════════════════╝                  │
##             │           imported            │
##             │──────────────────────────────>│
##             │            │                  │
##             │          change_a()           │
##             │<──────────────────────────────│
##             │            │                  │
##             │           ┌┴┐    import b     │
##             │           │ │ <───────────────│
##             │           │ │                 │
##             │  ╔════════╧═╧══════════╗      │
##             │  ║change_a_from_b() { ░║      │
##             │  ║  change_a();        ║      │
##             │  ║  print_a();         ║      │
##             │  ║}                    ║      │
##             │  ╚════════╤═╤══════════╝      │
##             │ import a  │ │                 │
##             │<─ ─ ─ ─ ─ │ │                 │
##             │           │ │                 │
##             │from cache │ │                 │
##             │ ─ ─ ─ ─ ─>│ │                 │
##             │           └┬┘                 │
##             │            │     imported     │
##             │            │ ─────────────────>
##             │            │                  │
##             │            │ change_a_from_b()│
##             │            │ <─────────────────
##             │            │                  │
##             │change_a()  │                  │
##             │<───────────│                  │
##             │            │                  │
##             │ print_a()  │                  │
##             │<───────────│                  │
##            ┌┴┐          ┌┴┐                ┌┴┐
##            │a│          │b│                │.│
##            └─┘          └─┘                └─┘
##
test_func_import__scope_4()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_4/a/a.sh
				shwrap_test_data__print_a
				shwrap_test_data__change_a "."
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_4/b/b.sh
				shwrap_test_data__change_a_from_b_and_print
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A->.->BB A->.->BB"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__scope_5`
##
## Check that a module scope is updated as expected in the case of an import
## chain looks like below.
##
##            ┌─┐          ┌─┐                ┌─┐
##            │a│          │b│                │.│
##            └┬┘          └┬┘                └┬┘
##             │           ┌┴┐    import b     │
##             │           │ │ <───────────────│
##             │           │ │                 │
##             │ ╔═════════╧═╧═════════╗       │
##             │ ║change_a_from_b() { ░║       │
##             │ ║  change_a();        ║       │
##             │ ║  print_a();         ║       │
##             │ ║}                    ║       │
##             │ ╚═════════╤═╤═════════╝       │
##            ┌┴┐ import a │ │                 │
##            │ │ <────────│ │                 │
##            │ │          │ │                 │
##  ╔═════════╧═╧══════════╧╗│                 │
##  ║VAR="A"               ░║│                 │
##  ║print_a() {...}        ║│                 │
##  ║change_a() {VAR="$1"}  ║│                 │
##  ╚══════════════════════╤╝│                 │
##             │imported   │ │                 │
##             │─────────> │ │                 │
##             │           └┬┘                 │
##             │            │    imported      │
##             │            │─────────────────>│
##             │            │                  │
##             │            │change_a_from_b() │
##             │            │<─────────────────│
##             │            │                  │
##             │change_a()  │                  │
##             │<───────────│                  │
##             │            │                  │
##             │ print_a()  │                  │
##             │<───────────│                  │
##            ┌┴┐          ┌┴┐                ┌┴┐
##            │a│          │b│                │.│
##            └─┘          └─┘                └─┘
##
test_func_import__scope_5()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_5/a/a.sh
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_5/b/b.sh
				shwrap_test_data__print_a
				shwrap_test_data__change_a_from_b_and_print
				shwrap_test_data__print_a
				shwrap_test_data__change_a "."
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A->BB A->BB A->BB->."
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__scope_6`
##
## Check that a module scope is updated as expected in the case of an import
## chain looks like below.
##
##            ┌─┐                      ┌─┐                     ┌─┐
##            │a│                      │b│                     │.│
##            └┬┘                      └┬┘                     └┬┘
##             │                       ┌┴┐       import b       │
##             │                       │ │ <────────────────────│
##             │                       │ │                      │
##             │              ╔════════╧═╧══════════╗           │
##             │              ║change_a_from_b() { ░║           │
##             │              ║  change_a();        ║           │
##             │              ║  print_a();         ║           │
##             │              ║}                    ║           │
##             │              ╚════════╤═╤══════════╝           │
##            ┌┴┐       import a       │ │                      │
##            │ │ <────────────────────│ │                      │
##            │ │                      │ │                      │
##  ╔═════════╧═╧═══════════╗          │ │                      │
##  ║VAR="A"               ░║          │ │                      │
##  ║print_a() {...}        ║          │ │                      │
##  ║change_a() {VAR="$1"}  ║          │ │                      │
##  ╚═════════╤═╤═══════════╝          │ │                      │
##            │ │────┐                 │ │                      │
##            │ │    │ call change_a() │ │                      │
##            │ │<───┘                 │ │                      │
##            └┬┘                      │ │                      │
##             │       imported        │ │                      │
##             │──────────────────────>│ │                      │
##             │                       │ │                      │
##             │call change_a_from_b() │ │                      │
##             │<──────────────────────│ │                      │
##             │                       │ │                      │
##             │   call change_a()     │ │                      │
##             │<──────────────────────│ │                      │
##             │                       │ │                      │
##             │    call print_a()     │ │                      │
##             │<──────────────────────│ │                      │
##             │                       └┬┘                      │
##             │                        │        imported       │
##             │                        │ ──────────────────────>
##             │                        │                       │
##             │                        │ call change_a_from_b()│
##             │                        │ <──────────────────────
##             │                        │                       │
##             │    call change_a()     │                       │
##             │<───────────────────────│                       │
##             │                        │                       │
##             │    call print_a()      │                       │
##             │<───────────────────────│                       │
##            ┌┴┐                      ┌┴┐                     ┌┴┐
##            │a│                      │b│                     │.│
##            └─┘                      └─┘                     └─┘
##
test_func_import__scope_6()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_6/b/b.sh
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__scope_6/a/a.sh
				shwrap_test_data__print_a
				shwrap_test_data__change_a_from_b_and_print
				shwrap_test_data__change_a "."
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A->A A->A->BB A->A->BB->B A->A->BB->B A->A->BB->B->BB A->A->BB->B->BB->."
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_1`
##
## Check that a module imports other module as expected in the case of an import
## chain looks like below.
##
##         ┌─┐          ┌─┐          ┌─┐
##         │a│          │b│          │.│
##         └┬┘          └┬┘          └┬┘
##         ┌┴┐        import a        │
##         │ │ <──────────────────────│
##         │ │           │            │
##  ╔══════╧═╧════════╗  │            │
##  ║print_a() {...} ░║  │            │
##  ╚══════╤═╤════════╝  │            │
##         │ │ import b ┌┴┐           │
##         │ │ ────────>│ │           │
##         │ │          │ │           │
##         │ │  ╔═══════╧═╧═══════╗   │
##         │ │  ║print_b() {...} ░║   │
##         │ │  ╚═════════════════╝   │
##         │ │ imported  │            │
##         │ │ <─────────│            │
##         └┬┘           │            │
##          │        imported         │
##          │────────────────────────>│
##          │            │            │
##          │     call print_a()      │
##          │<────────────────────────│
##         ┌┴┐          ┌┴┐          ┌┴┐
##         │a│          │b│          │.│
##         └─┘          └─┘          └─┘
##
test_func_import__import_1()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_1/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="B A A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_2`
##
## Check that a module imports other module as expected in the case of an import
## chain looks like below.
##
##          ┌─┐          ┌─┐          ┌─┐          ┌─┐
##          │a│          │b│          │c│          │.│
##          └┬┘          └┬┘          └┬┘          └┬┘
##          ┌┴┐           │  import a  │            │
##          │ │ <───────────────────────────────────│
##          │ │           │            │            │
##  ╔═══════╧═╧═══════╗   │            │            │
##  ║print_a() {...} ░║   │            │            │
##  ╚═══════╤═╤═══════╝   │            │            │
##          │ │ import b ┌┴┐           │            │
##          │ │ ────────>│ │           │            │
##          │ │          │ │           │            │
##          │ │  ╔═══════╧═╧═══════╗   │            │
##          │ │  ║print_b() {...} ░║   │            │
##          │ │  ╚═══════╤═╤═══════╝   │            │
##          │ │          │ │ import c ┌┴┐           │
##          │ │          │ │ ────────>│ │           │
##          │ │          │ │          │ │           │
##          │ │          │ │  ╔═══════╧═╧═══════╗   │
##          │ │          │ │  ║print_c() {...} ░║   │
##          │ │          │ │  ╚═════════════════╝   │
##          │ │          │ │ imported  │            │
##          │ │          │ │ <─────────│            │
##          │ │          │ │           │            │
##          │ │  ╔═══════╧═╧════════╗  │            │
##          │ │  ║declare print_c; ░║  │            │
##          │ │  ╚══════════════════╝  │            │
##          │ │ imported  │            │            │
##          │ │ <─────────│            │            │
##          │ │           │            │            │
##  ╔═══════╧═╧════════╗  │            │            │
##  ║declare print_b; ░║  │            │            │
##  ║declare print_c;  ║  │            │            │
##  ╚══════════════════╝  │            │            │
##           │            │ imported   │            │
##           │─────────────────────────────────────>│
##           │            │            │            │
##           │           call print_a()│            │
##           │<─────────────────────────────────────│
##           │            │            │            │
##           │           call print_b()│            │
##           │<─────────────────────────────────────│
##           │            │            │            │
##           │           call print_c()│            │
##           │<─────────────────────────────────────│
##          ┌┴┐          ┌┴┐          ┌┴┐          ┌┴┐
##          │a│          │b│          │c│          │.│
##          └─┘          └─┘          └─┘          └─┘
##
test_func_import__import_2()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_2/a/a.sh
				shwrap_test_data__print_a
				shwrap_test_data__print_b
				shwrap_test_data__print_c
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A B C"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_3`
##
## Check that a module imports other module as expected in the case of an import
## chain looks like below.
##
##          ┌─┐          ┌─┐          ┌─┐          ┌─┐
##          │a│          │b│          │c│          │.│
##          └┬┘          └┬┘          └┬┘          └┬┘
##          ┌┴┐           │  import a  │            │
##          │ │ <───────────────────────────────────│
##          │ │           │            │            │
##  ╔═══════╧═╧═══════╗   │            │            │
##  ║print_a() {...} ░║   │            │            │
##  ╚═══════╤═╤═══════╝   │            │            │
##          │ │ import b ┌┴┐           │            │
##          │ │ ────────>│ │           │            │
##          │ │          │ │           │            │
##          │ │  ╔═══════╧═╧═══════╗   │            │
##          │ │  ║print_b() {...} ░║   │            │
##          │ │  ╚═══════╤═╤═══════╝   │            │
##          │ │          │ │ import c ┌┴┐           │
##          │ │          │ │ ────────>│ │           │
##          │ │          │ │          │ │           │
##          │ │          │ │  ╔═══════╧═╧═══════╗   │
##          │ │          │ │  ║print_c() {...} ░║   │
##          │ │          │ │  ╚═════════════════╝   │
##          │ │          │ │ imported  │            │
##          │ │          │ │ <─────────│            │
##          │ │          │ │           │            │
##          │ │  ╔═══════╧═╧════════╗  │            │
##          │ │  ║declare print_c; ░║  │            │
##          │ │  ╚══════════════════╝  │            │
##          │ │ imported  │            │            │
##          │ │ <─────────│            │            │
##          │ │           │            │            │
##  ╔═══════╧═╧════════╗  │            │            │
##  ║declare print_b; ░║  │            │            │
##  ║declare print_c;  ║  │            │            │
##  ╚══════════════════╝  │            │            │
##           │            │ imported   │            │
##           │─────────────────────────────────────>│
##           │            │            │            │
##           │           call print_a()│            │
##           │<─────────────────────────────────────│
##           │            │            │            │
##           │           call print_b()│            │
##           │<─────────────────────────────────────│
##           │            │            │            │
##           │           call print_c()│            │
##           │<─────────────────────────────────────│
##          ┌┴┐          ┌┴┐          ┌┴┐          ┌┴┐
##          │a│          │b│          │c│          │.│
##          └─┘          └─┘          └─┘          └─┘
##
test_func_import__import_3()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_3/b/b.sh
				shwrap_test_data__import_a_from_b
				shwrap_test_data__change_a_from_b
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_3/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="B A A->A A->A->BB"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_4`
##
## Check that a module imports other module as expected in the case of an import
## chain looks like below.
##
##            ┌─┐                     ┌─┐             ┌─┐          ┌─┐
##            │a│                     │b│             │c│          │.│
##            └┬┘                     └┬┘             └┬┘          └┬┘
##            ┌┴┐                     import a         │            │
##            │ │ <─────────────────────────────────────────────────│
##            │ │                      │               │            │
##  ╔═════════╧═╧══════════╗           │               │            │
##  ║import_b_from_a() {  ░║           │               │            │
##  ║  import b;           ║           │               │            │
##  ║  import_c_from_b();  ║           │               │            │
##  ║}                     ║           │               │            │
##  ╚══════════════════════╝           │               │            │
##             │                     imported          │            │
##             │───────────────────────────────────────────────────>│
##             │                       │               │            │
##             │              call import_b_from_a()   │            │
##             │<───────────────────────────────────────────────────│
##             │                       │               │            │
##             │      import b        ┌┴┐              │            │
##             │────────────────────> │ │              │            │
##             │                      │ │              │            │
##             │            ╔═════════╧═╧═════════╗    │            │
##             │            ║import_c_from_b() { ░║    │            │
##             │            ║  import c;          ║    │            │
##             │            ║  print_c();         ║    │            │
##             │            ║}                    ║    │            │
##             │            ╚═════════════════════╝    │            │
##             │       imported        │               │            │
##             │<──────────────────────│               │            │
##             │                       │               │            │
##             │call import_c_from_b() │               │            │
##             │──────────────────────>│               │            │
##             │                       │               │            │
##             │                       │  import c    ┌┴┐           │
##             │                       │────────────> │ │           │
##             │                       │              │ │           │
##             │                       │      ╔═══════╧═╧═══════╗   │
##             │                       │      ║print_c() {...} ░║   │
##             │                       │      ╚═════════════════╝   │
##             │                       │   imported    │            │
##             │                       │<──────────────│            │
##             │                       │               │            │
##             │                       │call print_c() │            │
##             │                       │──────────────>│            │
##            ┌┴┐                     ┌┴┐             ┌┴┐          ┌┴┐
##            │a│                     │b│             │c│          │.│
##            └─┘                     └─┘             └─┘          └─┘
##
test_func_import__import_4()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_4/a/a.sh
				shwrap_test_data__import_b_from_a_and_print
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A B C"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__cyclical_import_1`
##
## Check that a module imports other module with a cyclical dependency as
## expected in the case of an import chain looks like below.
##
##         ┌─┐                    ┌─┐          ┌─┐
##         │a│                    │b│          │.│
##         └┬┘                    └┬┘          └┬┘
##         ┌┴┐             import a│            │
##         │ │ <────────────────────────────────│
##         │ │                     │            │
##  ╔══════╧═╧════════╗            │            │
##  ║print_a() {...} ░║            │            │
##  ╚══════╤═╤════════╝            │            │
##         │ │      import b      ┌┴┐           │
##         │ │ ──────────────────>│ │           │
##         │ │                    │ │           │
##         │ │            ╔═══════╧═╧═══════╗   │
##         │ │            ║print_b() {...} ░║   │
##         │ │            ╚═══════╤═╤═══════╝   │
##         │ │      import a      │ │           │
##         │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ │ │           │
##         │ │                    │ │           │
##         │ │ imported partially │ │           │
##         │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─>│ │           │
##         │ │                    │ │           │
##         │ │   call print_a()   │ │           │
##         │ │ <──────────────────│ │           │
##         │ │                    └┬┘           │
##         │ │      imported       │            │
##         │ │ <───────────────────│            │
##         │ │                     │            │
##         │ │   call print_b()    │            │
##         │ │ ───────────────────>│            │
##         └┬┘                     │            │
##          │             imported │            │
##          │──────────────────────────────────>│
##          │                      │            │
##          │     fix import       │            │
##          │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│            │
##         ┌┴┐                    ┌┴┐          ┌┴┐
##         │a│                    │b│          │.│
##         └─┘                    └─┘          └─┘
##
test_func_import__cyclical_import_1()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_1/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A B A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__cyclical_import_2`
##
## Check that a module imports other module with a cyclical dependency as
## expected in the case of an import chain looks like below.
##
##         ┌─┐                    ┌─┐              ┌─┐
##         │a│                    │b│              │c│
##         └┬┘                    └┬┘              └┬┘
##  ╔═════════════════╗            │                │
##  ║print_a() {...} ░║            │                │
##  ╚══════╤═╤════════╝            │                │
##         │ │      import b      ┌┴┐               │
##         │ │ ──────────────────>│ │               │
##         │ │                    │ │               │
##         │ │            ╔═══════╧═╧═══════╗       │
##         │ │            ║print_b() {...} ░║       │
##         │ │            ╚═══════╤═╤═══════╝       │
##         │ │      import a      │ │               │
##         │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ │ │               │
##         │ │                    │ │               │
##         │ │ imported partially │ │               │
##         │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─>│ │               │
##         │ │                    │ │               │
##         │ │                    │ │   import c   ┌┴┐
##         │ │                    │ │ ────────────>│ │
##         │ │                    │ │              │ │
##         │ │                    │ │       ╔══════╧═╧════════╗
##         │ │                    │ │       ║print_c() {...} ░║
##         │ │                    │ │       ╚═════════════════╝
##         │ │                    │ │    imported   │
##         │ │                    │ │ <──────────────
##         │ │                    │ │               │
##         │ │   call print_a()   │ │               │
##         │ │ <──────────────────│ │               │
##         │ │                    │ │               │
##         │ │                    │ │ call print_c()│
##         │ │                    │ │ ──────────────>
##         │ │                    └┬┘               │
##         │ │      imported       │                │
##         │ │ <───────────────────│                │
##         │ │                     │                │
##         │ │               import c               │
##         │ │ ─────────────────────────────────────>
##         │ │                     │                │
##         │ │              from cache              │
##         │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
##         │ │                     │                │
##         │ │   call print_b()    │                │
##         │ │ ───────────────────>│                │
##         │ │                     │                │
##         │ │            call print_c()            │
##         │ │ ─────────────────────────────────────>
##         └┬┘                     │                │
##          │     fix import       │                │
##          │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│                │
##         ┌┴┐                    ┌┴┐              ┌┴┐
##         │a│                    │b│              │c│
##         └─┘                    └─┘              └─┘
##
test_func_import__cyclical_import_2()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_2/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A C B C A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__cyclical_import_3`
##
## Check that a module imports other module with a cyclical dependency as
## expected in the case of an import chain looks like below.
##
##          ┌─┐                    ┌─┐              ┌─┐
##          │a│                    │b│              │c│
##          └┬┘                    └┬┘              └┬┘
##  ╔══════════════════╗            │                │
##  ║print_a1() {...} ░║            │                │
##  ╚═══════╤═╤════════╝            │                │
##          │ │      import b      ┌┴┐               │
##          │ │ ──────────────────>│ │               │
##          │ │                    │ │               │
##          │ │            ╔═══════╧═╧═══════╗       │
##          │ │            ║print_b() {...} ░║       │
##          │ │            ╚═══════╤═╤═══════╝       │
##          │ │                    │ │   import c   ┌┴┐
##          │ │                    │ │ ────────────>│ │
##          │ │                    │ │              │ │
##          │ │                    │ │       ╔══════╧═╧════════╗
##          │ │                    │ │       ║print_c() {...} ░║
##          │ │                    │ │       ╚══════╤═╤════════╝
##          │ │              import a│              │ │
##          │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│ │
##          │ │                    │ │              │ │
##          │ │         imported partially          │ │
##          │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│ │
##          │ │                    │ │              │ │
##          │ │           call print_a()            │ │
##          │ │ <───────────────────────────────────│ │
##          │ │                    │ │              └┬┘
##          │ │                    │ │    imported   │
##          │ │                    │ │ <──────────────
##          │ │                    │ │               │
##          │ │      import a      │ │               │
##          │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ │ │               │
##          │ │                    │ │               │
##          │ │ imported partially │ │               │
##          │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─>│ │               │
##          │ │                    │ │               │
##          │ │                    │ │ call print_c()│
##          │ │                    │ │ ──────────────>
##          │ │                    │ │               │
##          │ │   call print_a()   │ │               │
##          │ │ <──────────────────│ │               │
##          │ │                    └┬┘               │
##          │ │      imported       │                │
##          │ │ <───────────────────│                │
##          │ │                     │                │
##          │ │               import c               │
##          │ │ ─────────────────────────────────────>
##          │ │                     │                │
##          │ │              from cache              │
##          │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
##          │ │                     │                │
##          │ │   call print_a()    │                │
##          │ │ ───────────────────>│                │
##          │ │                     │                │
##          │ │            call print_c()            │
##          │ │ ─────────────────────────────────────>
##          └┬┘                     │                │
##           │     fix import       │                │
##           │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│                │
##           │                      │                │
##           │              fix import               │
##           │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─>│
##          ┌┴┐                    ┌┴┐              ┌┴┐
##          │a│                    │b│              │c│
##          └─┘                    └─┘              └─┘
##
test_func_import__cyclical_import_3()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_3/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A C A B C A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__cyclical_import_4`
##
## Check that a module imports other module with a cyclical dependency as
## expected in the case of an import chain looks like below.
##
##          ┌─┐                    ┌─┐          ┌─┐             ┌─┐
##          │a│                    │b│          │c│             │.│
##          └┬┘                    └┬┘          └┬┘             └┬┘
##          ┌┴┐                     import a     │               │
##          │ │ <────────────────────────────────────────────────│
##          │ │                     │            │               │
##  ╔═══════╧═╧════════╗            │            │               │
##  ║print_a1() {...} ░║            │            │               │
##  ╚═══════╤═╤════════╝            │            │               │
##          │ │      import b      ┌┴┐           │               │
##          │ │ ──────────────────>│ │           │               │
##          │ │                    │ │           │               │
##          │ │            ╔═══════╧═╧═══════╗   │               │
##          │ │            ║print_b() {...} ░║   │               │
##          │ │            ╚═══════╤═╤═══════╝   │               │
##          │ │      import a      │ │           │               │
##          │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ │ │           │               │
##          │ │                    │ │           │               │
##          │ │ imported partially │ │           │               │
##          │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─>│ │           │               │
##          │ │                    │ │           │               │
##          │ │  call print_a1()   │ │           │               │
##          │ │ <──────────────────│ │           │               │
##          │ │                    └┬┘           │               │
##          │ │      imported       │            │               │
##          │ │ <───────────────────│            │               │
##          │ │                     │            │               │
##          │ │            import c │           ┌┴┐              │
##          │ │ ───────────────────────────────>│ │              │
##          │ │                     │           │ │              │
##          │ │                     ╔═══════════╧═╧═══════════╗  │
##          │ │                     ║print_c() { print_a3; } ░║  │
##          │ │                     ╚═══════════╤═╤═══════════╝  │
##  ╔═══════╧═╧════════╗            │           │ │              │
##  ║print_a2() {...} ░║            │           │ │              │
##  ╚═══════╤═╤════════╝            │           │ │              │
##          │ │            import a │           │ │              │
##          │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─│ │              │
##          │ │                     │           │ │              │
##          │ │       imported partially        │ │              │
##          │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│ │              │
##          │ │                     │           │ │              │
##          │ │         call print_a1()         │ │              │
##          │ │ <───────────────────────────────│ │              │
##          │ │                     │           │ │              │
##          │ │         call print_a2()         │ │              │
##          │ │ <───────────────────────────────│ │              │
##          │ │                     │           └┬┘              │
##          │ │             imported│            │               │
##          │ │ <────────────────────────────────│               │
##          │ │                     │            │               │
##  ╔═══════╧═╧════════╗            │            │               │
##  ║print_a3() {...} ░║            │            │               │
##  ╚═══════╤═╤════════╝            │            │               │
##          │ │   call print_b()    │            │               │
##          │ │ ───────────────────>│            │               │
##          │ │                     │            │               │
##          │ │          call print_c()          │               │
##          │ │ ────────────────────────────────>│               │
##          │ │                     │            │               │
##          │ │                     │  ╔═════════╧══════════╗    │
##          │ │                     │  ║error: no print_a3 ░║    │
##          └┬┘                     │  ╚═════════╤══════════╝    │
##           │                     imported      │               │
##           │──────────────────────────────────────────────────>│
##           │                      │            │               │
##           │     fix import       │            │               │
##           │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│            │               │
##           │                      │            │               │
##           │            fix import│            │               │
##           │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─>│               │
##           │                      │            │               │
##           │                      │            │call print_c() │
##           │                      │            │<──────────────│
##           │                      │            │               │
##           │         call print_a3()           │               │
##           │<──────────────────────────────────│               │
##          ┌┴┐                    ┌┴┐          ┌┴┐             ┌┴┐
##          │a│                    │b│          │c│             │.│
##          └─┘                    └─┘          └─┘             └─┘
##
test_func_import__cyclical_import_4()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_4/a/a.sh
				shwrap_test_data__print_c
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A1 A1 A2 B A3"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__cyclical_import_5`
##
## Check that a module imports other module with a cyclical dependency as
## expected in the case of an import chain looks like below.
##
##        ┌─┐                    ┌─┐                  ┌─┐
##        │a│                    │b│                  │.│
##        └┬┘                    └┬┘                  └┬┘
##        ┌┴┐                 import a                 │
##        │ │ <────────────────────────────────────────│
##        │ │                     │                    │
##  ╔═════╧═╧═══════╗             │                    │
##  ║print() {...} ░║             │                    │
##  ╚═════╤═╤═══════╝             │                    │
##        │ │────┐                │                    │
##        │ │    │ call print()   │                    │
##        │ │<───┘                │                    │
##        │ │                     │                    │
##        │ │      import b      ┌┴┐                   │
##        │ │ ──────────────────>│ │                   │
##        │ │                    │ │                   │
##        │ │             ╔══════╧═╧══════╗            │
##        │ │             ║print() {...} ░║            │
##        │ │             ╚══════╤═╤══════╝            │
##        │ │                    │ │────┐              │
##        │ │                    │ │    │ call print() │
##        │ │                    │ │<───┘              │
##        │ │                    │ │                   │
##        │ │      import a      │ │                   │
##        │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ │ │                   │
##        │ │                    │ │                   │
##        │ │ imported partially │ │                   │
##        │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─>│ │                   │
##        │ │                    │ │                   │
##        │ │    call print()    │ │                   │
##        │ │ <──────────────────│ │                   │
##        │ │                    └┬┘                   │
##        │ │      imported       │                    │
##        │ │ <───────────────────│                    │
##        │ │                     │                    │
##        │ │    call print()     │                    │
##        │ │ ───────────────────>│                    │
##        └┬┘                     │                    │
##         │                 imported                  │
##         │──────────────────────────────────────────>│
##         │                      │                    │
##         │     fix import       │                    │
##         │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│                    │
##         │                      │                    │
##         │               call print()                │
##         │<──────────────────────────────────────────│
##        ┌┴┐                    ┌┴┐                  ┌┴┐
##        │a│                    │b│                  │.│
##        └─┘                    └─┘                  └─┘
##
test_func_import__cyclical_import_5()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_5/a/a.sh
				shwrap_test_data__print
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A B A A A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__cyclical_import_6`
##
## Check that a module imports other module with a cyclical dependency as
## expected in the case of an import chain looks like below.
##
##          ┌─┐                    ┌─┐
##          │a│                    │b│
##          └┬┘                    └┬┘
##  ╔══════════════════╗            │
##  ║print_a() {...}  ░║            │
##  ║change_a() {...}  ║            │
##  ╚═══════╤═╤════════╝            │
##          │ │      import b      ┌┴┐
##          │ │ ──────────────────>│ │
##          │ │                    │ │
##          │ │            ╔═══════╧═╧════════╗
##          │ │            ║print_b() {...}  ░║
##          │ │            ║change_b() {...}  ║
##          │ │            ╚═══════╤═╤════════╝
##          │ │      import a      │ │
##          │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ │ │
##          │ │                    │ │
##          │ │ imported partially │ │
##          │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─>│ │
##          │ │                    │ │
##          │ │  call change_a()   │ │
##          │ │ <──────────────────│ │
##          │ │                    └┬┘
##          │ │      imported       │
##          │ │ <───────────────────│
##          │ │                     │
##          │ │   call change_b()   │
##          │ │ ───────────────────>│
##          └┬┘                     │
##           │     fix import       │
##           │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│
##          ┌┴┐                    ┌┴┐
##          │a│                    │b│
##          └─┘                    └─┘
##
test_func_import__cyclical_import_6()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_6/a/a.sh
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_6/b/b.sh
				shwrap_test_data__print_a
				shwrap_test_data__print_b
				shwrap_test_data__change_a "."
				shwrap_test_data__change_b "."
				shwrap_test_data__print_a
				shwrap_test_data__print_b
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A B A->B B A->B B A->B B->A A->B B->A A->B->. B->A->."
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__cyclical_import_7`
##
## Check that a module imports other module with a cyclical dependency as
## expected in the case of an import chain looks like below.
##
##          ┌─┐                      ┌─┐
##          │a│                      │b│
##          └┬┘                      └┬┘
##  ╔══════════════════╗              │
##  ║print_a() {...}  ░║              │
##  ║change_a() {...}  ║              │
##  ╚═══════╤═╤════════╝              │
##          │ │       import b       ┌┴┐
##          │ │ ────────────────────>│ │
##          │ │                      │ │
##          │ │      ╔═══════════════╧═╧═════════════════╗
##          │ │      ║print_b() {...}                   ░║
##          │ │      ║change_a_from_b() { change_a(); }  ║
##          │ │      ╚═══════════════╤═╤═════════════════╝
##          │ │       import a       │ │
##          │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │ │
##          │ │                      │ │
##          │ │  imported partially  │ │
##          │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─>│ │
##          │ │                      │ │
##          │ │   call change_a()    │ │
##          │ │ <────────────────────│ │
##          │ │                      └┬┘
##          │ │        imported       │
##          │ │ <──────────────────────
##          │ │                       │
##          │ │ call change_a_from_b()│
##          │ │ ──────────────────────>
##          │ │                       │
##          │ │    call change_a()    │
##          │ │ <──────────────────────
##          └┬┘                       │
##           │      fix import        │
##           │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│
##          ┌┴┐                      ┌┴┐
##          │a│                      │b│
##          └─┘                      └─┘
##
test_func_import__cyclical_import_7()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_7/a/a.sh
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_7/b/b.sh
				shwrap_test_data__print_a
				shwrap_test_data__change_a_from_b
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A->B A->B A->B->BB A->B->BB A->B->BB->BB"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__cyclical_import_8`
##
## Check that a module imports other module with a cyclical dependency as
## expected in the case of an import chain looks like below.
##
##              ┌─┐                      ┌─┐
##              │a│                      │b│
##              └┬┘                      └┬┘
##  ╔══════════════════════════╗          │
##  ║print_a() {...}          ░║          │
##  ║change_a() { VAR="$1"; }  ║          │
##  ╚═══════════╤═╤════════════╝          │
##              │ │       import b       ┌┴┐
##              │ │ ────────────────────>│ │
##              │ │                      │ │
##              │ │      ╔═══════════════╧═╧═════════════════╗
##              │ │      ║change_a_from_b() { change_a(); } ░║
##              │ │      ╚═══════════════╤═╤═════════════════╝
##              │ │       import a       │ │
##              │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │ │
##              │ │                      │ │
##              │ │  imported partially  │ │
##              │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─>│ │
##              │ │                      │ │
##              │ │   call change_a()    │ │
##              │ │ <────────────────────│ │
##              │ │                      └┬┘
##              │ │        imported       │
##              │ │ <──────────────────────
##              │ │                       │
##      ╔═══════╧═╧═══════╗               │
##      ║VAR="${VALUE1}" ░║               │
##      ╚═══════╤═╤═══════╝               │
##              │ │ call change_a_from_b()│
##              │ │ ──────────────────────>
##              │ │                       │
##              │ │    call change_a()    │
##              │ │ <──────────────────────
##              │ │                       │
##      ╔═══════╧═╧═══════╗               │
##      ║VAR="${VALUE2}" ░║               │
##      ╚═════════════════╝               │
##               │      fix import        │
##               │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│
##              ┌┴┐                      ┌┴┐
##              │a│                      │b│
##              └─┘                      └─┘
##
test_func_import__cyclical_import_8()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_8/a/a.sh
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_8/b/b.sh
				shwrap_test_data__print_a
				shwrap_test_data__change_a "."
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A->B AAA1 AAA1->BB->A AAA2 AAA2->."
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__cyclical_import_9`
##
## Check that a module imports other module with a cyclical dependency as
## expected in the case of an import chain looks like below.
##
##              ┌─┐                      ┌─┐
##              │a│                      │b│
##              └┬┘                      └┬┘
##  ╔══════════════════════════╗          │
##  ║print_a() {...}          ░║          │
##  ║change_a() { VAR="$1"; }  ║          │
##  ╚═══════════╤═╤════════════╝          │
##              │ │       import b       ┌┴┐
##              │ │ ────────────────────>│ │
##              │ │                      │ │
##              │ │      ╔═══════════════╧═╧═════════════════╗
##              │ │      ║import_a_from_b() { import a; }   ░║
##              │ │      ║change_a_from_b() { change_a(); }  ║
##              │ │      ╚═══════════════════════════════════╝
##              │ │        imported       │
##              │ │ <──────────────────────
##              │ │                       │
##              │ │ call import_a_from_b()│
##              │ │ ──────────────────────>
##              │ │                       │
##              │ │        import a       │
##              │ │ <─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
##              │ │                       │
##              │ │   imported partially  │
##              │ │  ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─>
##              │ │                       │
##              │ │ call change_a_from_b()│
##              │ │ ──────────────────────>
##              │ │                       │
##              │ │    call change_a()    │
##              │ │ <──────────────────────
##              └┬┘                       │
##               │      fix import        │
##               │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ >│
##              ┌┴┐                      ┌┴┐
##              │a│                      │b│
##              └─┘                      └─┘
##
test_func_import__cyclical_import_9()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__cyclical_import_9/a/a.sh
				shwrap_test_data__print_a
				shwrap_test_data__change_a "."
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A->B AAA1 AAA1->BB->A AAA2 AAA2->."
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_search_user_paths`
##
## Check that default import from user paths is successful.
##
test_func_import__import_search_user_paths()
{
	# shellcheck disable=SC2034
	# used by search module
	declare -a SHWRAP_MODULE_PATHS=(
		"$(realpath "${SHWRAP_TEST_CASE_DATA}"/_common)"
	)
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_search_user_paths/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="C C C A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_search_user_paths`
##
## Check that default import from user paths is successful.
##
test_func_import__import_search_load_paths()
{
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_search_load_paths/abc/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="C B C A B A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}

## # `test_func_import__import_search_default_path`
##
## Check that default import from default path is successful.
##
test_func_import__import_search_default_path()
{
	declare -g SHWRAP_MODULE_PATH
	# shellcheck disable=SC2034
	# used by search module
	SHWRAP_MODULE_PATH=$(realpath "${SHWRAP_TEST_CASE_DATA}"/_common)
	local stdout
	stdout=$({
				shwrap_import "${SHWRAP_TEST_CASE_DATA}"/test_func_import__import_search_default_path/a/a.sh
				shwrap_test_data__print_a
			})
	stdout=$(cat <<< "${stdout}" | xargs)
	local expected_stdout="A A B C A B C A"
	[[ "${stdout}" == "${expected_stdout}" ]]
}
