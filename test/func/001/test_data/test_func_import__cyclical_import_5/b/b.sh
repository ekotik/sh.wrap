shwrap_test_data__print() { echo "B"; }

declare -fx shwrap_test_data__print

shwrap_test_data__print

shwrap_import ../a/a.sh

shwrap_test_data__print
