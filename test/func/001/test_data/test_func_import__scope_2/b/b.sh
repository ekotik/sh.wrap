source "${BASH_SOURCE[0]%/*}"/../../_common/b_scope/b.sh

shwrap_import ../a/a.sh

shwrap_test_data__print_a
shwrap_test_data__change_a "B"
shwrap_test_data__print_a
