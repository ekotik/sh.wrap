shwrap_test_data__print_a1() { echo "A1"; }

declare -fx shwrap_test_data__print_a1

shwrap_import ../b/b.sh

shwrap_test_data__print_a2() { echo "A2"; }

declare -fx shwrap_test_data__print_a2

shwrap_import ../c/c.sh

declare -fx shwrap_test_data__print_c

shwrap_test_data__print_a3() { echo "A3"; }

declare -fx shwrap_test_data__print_a3

shwrap_test_data__print_b
shwrap_test_data__print_c
