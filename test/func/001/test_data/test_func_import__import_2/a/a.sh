source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

shwrap_import ../b/b.sh

declare -fx shwrap_test_data__print_b
declare -fx shwrap_test_data__print_c
