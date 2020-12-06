/'
	fbcunit example

		- use of SUITE_INIT and SUITE_CLEANUP macros
		- suite has code that has to run before
		  and after the suite
'/

#include once "fbcunit.bi"

SUITE( ex04 )

	dim shared cmn_data as string

	SUITE_INIT
		cmn_data = "COMMON DATA"
		'' return success
		return 0
	END_SUITE_INIT

	SUITE_CLEANUP
		cmn_data = ""
		'' return success
		return 0
	END_SUITE_CLEANUP

	TEST( t3 )
		CU_ASSERT_EQUAL( cmn_data, "COMMON DATA" )
	END_TEST

	TEST( t2 )
		CU_ASSERT_EQUAL( cmn_data, "COMMON DATA" )
	END_TEST

	TEST( t1 )
		CU_ASSERT_EQUAL( cmn_data, "COMMON DATA" )
	END_TEST

END_SUITE

fbcu.run_tests
