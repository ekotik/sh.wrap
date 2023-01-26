declare -g SHWRAP_TEST_DATA__VAR="B"

shwrap_test_data__print() { echo "${SHWRAP_TEST_DATA__VAR}"; }
shwrap_test_data__print_b() { echo "${SHWRAP_TEST_DATA__VAR}"; }
shwrap_test_data__change_b() { SHWRAP_TEST_DATA__VAR="${SHWRAP_TEST_DATA__VAR}->$1"; }

declare -fx shwrap_test_data__print
declare -fx shwrap_test_data__print_b
declare -fx shwrap_test_data__change_b
