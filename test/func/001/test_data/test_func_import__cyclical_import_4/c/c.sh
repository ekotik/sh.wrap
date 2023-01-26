source "${BASH_SOURCE[0]%/*}"/../../_common/c_scope/c.sh

shwrap_import ../a/a.sh

shwrap_test_data__print_a1
shwrap_test_data__print_a2
