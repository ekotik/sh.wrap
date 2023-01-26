shwrap_test_data__print() { echo "A"; }

declare -fx shwrap_test_data__print

shwrap_test_data__print

shwrap_import ../b/b.sh

shwrap_test_data__print
