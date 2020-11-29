/'
	fbcunit example

		- enable or disable console output
'/

#include once "fbcunit.bi"

'' console output functions

SUITE( ex11 )

	TEST( console )

		CU_PRINT( "by default console output is disabled" )
		CU_PASS()

		fbcu.setShowConsole( true )
		CU_PRINT( "this will be output to console" )
		CU_PASS()

		fbcu.outputConsoleString( "this will be output to console also" )
		CU_PASS()

		fbcu.setShowConsole( false )
		CU_PRINT( "disable output to console again" )
		CU_PASS()

	END_TEST

END_SUITE

fbcu.run_tests
