source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

B=$(realpath "${BASH_SOURCE[0]%/*}"/../b/b.sh)

shwrap_test_data__import_b_from_a_and_print()
{
	shwrap_import "${B}"
	shwrap_test_data__print_a
	shwrap_test_data__import_c_from_b_and_print
}

declare -fx shwrap_test_data__import_b_from_a_and_print
