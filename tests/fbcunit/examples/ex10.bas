/'
	fbcunit example

		- show or hide failed cases
'/

#include once "fbcunit.bi"

'' console output functions

SUITE( ex10 )

	TEST( cases )

		CU_FAIL( "by default show failed cases" )

		fbcu.setHideCases( true )
		CU_FAIL( "this will be hidden" )

		fbcu.setHideCases( false )
		CU_FAIL( "enable showing failed cases" )

	END_TEST

END_SUITE

fbcu.run_tests

