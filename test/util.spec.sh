setup()
{
	local SHWRAP_INIT_DIR=$(dirname "${BASH_SOURCE}")/../src
	source "${SHWRAP_INIT_DIR}"/util.sh
}

: "
test__shwrap_log_1

This test checks exit status of '__shwrap_log' function when 'SHWRAP_MODULE_LOG'
is set.
"
test__shwrap_log_1()
{
	SHWRAP_MODULE_LOG=true
	__shwrap_log "nothing"
}

: "
test__shwrap_log_2

This test checks exit status of '__shwrap_log' function when 'SHWRAP_MODULE_LOG'
is not set.
"
test__shwrap_log_2()
{
	__shwrap_log "nothing"
}
