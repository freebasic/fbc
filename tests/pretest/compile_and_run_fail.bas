
' TEST_MODE : COMPILE_AND_RUN_FAIL

/'
	COMPILE_AND_RUN_FAIL tag indicates that this file is
	tested as part of the log-tests.mk testing method

	Expected results:
		1) compile successfully
		2) execute and fail at run-time on assertion 
		   and return non-zero exit code
		3) reported as success by log-tests.mk 
'/

ASSERT( 0=1 )

end 0

