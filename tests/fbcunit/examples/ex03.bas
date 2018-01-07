/'
	fbcunit example

		- use of SUITE & TEST macros
		- tests are added to the list of tests
		- fbcu.run_tests executes tests and shows results
'/

#include once "fbcunit.bi"

SUITE( ex03_A )

	TEST( first )
		CU_ASSERT( true )
		CU_ASSERT( false )
	END_TEST

	TEST( second )
		CU_ASSERT( true )
		CU_ASSERT( false )
	END_TEST

END_SUITE

SUITE( ex03_B )

	TEST( first )
		CU_ASSERT( true )
		CU_ASSERT( false )
	END_TEST

	TEST( second )
		CU_ASSERT( true )
		CU_ASSERT( false )
	END_TEST

END_SUITE

fbcu.run_tests
