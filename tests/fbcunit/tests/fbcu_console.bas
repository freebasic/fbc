#include once "fbcunit.bi"

'' console output functions

SUITE( console )

	TEST( get_set )

		'' get current setting
		var flag = fbcu.getShowConsole()
		CU_PRINT( "current setting of showConsole is " & flag )

		fbcu.setShowConsole( true )
		CU_ASSERT( fbcu.getShowConsole() = true )

		fbcu.setShowConsole( false )
		CU_ASSERT( fbcu.getShowConsole() = false )

		fbcu.setShowConsole( flag )
		CU_ASSERT( fbcu.getShowConsole() = flag )

	END_TEST

END_SUITE
