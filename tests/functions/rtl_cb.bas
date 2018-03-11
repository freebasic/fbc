# include "fbcunit.bi"

SUITE( fbc_tests.compound.rtl_cb )

	'' take sleep's address
    TEST( addressOfSleepRtl )
		var p = @sleep
	END_TEST
	
END_SUITE
