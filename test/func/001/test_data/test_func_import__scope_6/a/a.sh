source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

shwrap_test_data__print_a
shwrap_test_data__change_a "A"
shwrap_test_data__print_a
