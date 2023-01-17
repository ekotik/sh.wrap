declare -g SHWRAP_TEST_DATA__VAR="A"

shwrap_test_data__print() { echo "${SHWRAP_TEST_DATA__VAR}"; }
shwrap_test_data__print_a() { echo "${SHWRAP_TEST_DATA__VAR}"; }
shwrap_test_data__change_a() { SHWRAP_TEST_DATA__VAR="${SHWRAP_TEST_DATA__VAR}->$1"; }

declare -fx shwrap_test_data__print
declare -fx shwrap_test_data__print_a
declare -fx shwrap_test_data__change_a
