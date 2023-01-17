source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

shwrap_test_data__change_a_from_b()
{
	shwrap_test_data__change_a "BB"
}

declare -fx shwrap_test_data__change_a_from_b

shwrap_import ../a/a.sh

shwrap_test_data__print_a
shwrap_test_data__change_a_from_b
shwrap_test_data__print_a
