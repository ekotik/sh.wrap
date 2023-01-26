declare -g SHWRAP_TEST_DATA__VAR="C"

shwrap_test_data__print() { echo "${SHWRAP_TEST_DATA__VAR}"; }
shwrap_test_data__print_c() { echo "${SHWRAP_TEST_DATA__VAR}"; }
shwrap_test_data__change_c() { SHWRAP_TEST_DATA__VAR="${SHWRAP_TEST_DATA__VAR}->$1"; }

declare -fx shwrap_test_data__print
declare -fx shwrap_test_data__print_c
declare -fx shwrap_test_data__change_c
