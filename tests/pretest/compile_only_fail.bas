
' TEST_MODE : COMPILE_ONLY_FAIL

/'
	COMPILE_ONLY_FAIL tag indicates that this file is
	tested as part of the log-tests.mk testing method

	Expected results:
		1) fail compilation and return non-zero exit code from fbc compiler
		2) reported as success by log-tests.mk 
'/

dim x as invalid_type

end 0

