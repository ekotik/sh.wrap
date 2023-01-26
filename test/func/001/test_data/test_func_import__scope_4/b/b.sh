source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

shwrap_test_data__change_a_from_b_and_print()
{
	shwrap_test_data__change_a "BB"
	shwrap_test_data__print_a
}

declare -fx shwrap_test_data__change_a_from_b_and_print

shwrap_import ../a/a.sh
