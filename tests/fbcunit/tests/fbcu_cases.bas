#include once "fbcunit.bi"

'' console output functions

SUITE( cases )

	TEST( get_set )

		'' get current setting
		var flag = fbcu.getHideCases()
		CU_PRINT( "current setting of hideCases is " & flag )

		fbcu.setHideCases( true )
		CU_ASSERT( fbcu.getHideCases() = true )

		fbcu.setHideCases( false )
		CU_ASSERT( fbcu.getHideCases() = false )

		fbcu.setHideCases( flag )
		CU_ASSERT( fbcu.getHideCases() = flag )

	END_TEST

END_SUITE
