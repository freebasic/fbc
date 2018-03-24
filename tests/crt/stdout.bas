# include once "fbcunit.bi"
# include once "crt.bi"

SUITE( fbc_tests.crt.stdout_ )

	'// !!! TODO !!! improve fbcunit API (see below)
	'// we want to compile the test and only run it if an option is given
	'// fbcunit should handle this internally ...
	'// need to add capability to fbcunit

	# if ENABLE_CONSOLE_OUTPUT
		TEST( test1 )
			fputs( "hello", stdout )
			CU_PASS("just a compile check")
		END_TEST
	# endif

END_SUITE
