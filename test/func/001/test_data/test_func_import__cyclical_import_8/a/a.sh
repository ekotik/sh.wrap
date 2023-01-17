source "${BASH_SOURCE[0]%/*}"/../../_common/a_scope/a.sh

shwrap_import ../b/b.sh

SHWRAP_TEST_DATA__VAR="AAA1"
shwrap_test_data__print_a
shwrap_test_data__change_a_from_b
shwrap_test_data__change_a "A"
shwrap_test_data__print_a
SHWRAP_TEST_DATA__VAR="AAA2"
