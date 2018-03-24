
' TEST_MODE : COMPILE_AND_RUN_OK

/'
	COMPILE_AND_RUN_OK tag indicates that this file is
	tested as part of the log-tests.mk testing method

	Expected results:
		1) compile
		2) execute with no assertions failed and 
		   return exit code of zero (success)
		3) reported as success by log-tests.mk
'/

ASSERT( 0=0 )

end 0

