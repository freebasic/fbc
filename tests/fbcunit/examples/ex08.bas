/'
	fbcunit example

		- write the report to results.xml
		- force an unexpeced failure
'/

#include once "fbcunit.bi"

SUITE( ex08 )
	TEST( passed )
		CU_ASSERT( true )
	END_TEST

	TEST( failed )
		CU_ASSERT( false )
	END_TEST

	TEST( abort )
		CU_FAIL_FATAL( aborting tests )
	END_TEST
END_SUITE

fbcu.run_tests

