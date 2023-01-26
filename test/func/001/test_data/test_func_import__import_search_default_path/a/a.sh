shwrap_import a_scope/a.sh

declare -fx shwrap_test_data__print_a

shwrap_test_data__print_a

export SHWRAP_MODULE_PATH=$(realpath "${BASH_SOURCE[0]%/*}"/../abc)

shwrap_import a/a.sh
shwrap_import a/b/b.sh
shwrap_import a/b/c/c.sh

shwrap_test_data__print_a
shwrap_test_data__print_b
shwrap_test_data__print_c
