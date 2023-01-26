source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

shwrap_import ./a.sh

shwrap_test_data__print_a
