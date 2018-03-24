# include "fbcunit.bi"

SUITE( fbc_tests.functions.rtl_cb )

	'' take sleep's address
    TEST( addressOfSleepRtl )
		var p = @sleep
	END_TEST
	
END_SUITE
