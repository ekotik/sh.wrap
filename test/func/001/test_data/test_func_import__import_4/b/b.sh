source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

C=$(realpath "${BASH_SOURCE[0]%/*}"/../c/c.sh)

shwrap_test_data__import_c_from_b_and_print()
{
	shwrap_import "${C}"
	shwrap_test_data__print_b
	shwrap_test_data__print_c
}

declare -fx shwrap_test_data__import_c_from_b_and_print
