
' TEST_MODE : FBCUNIT_COMPATIBLE

#include "fbcunit.bi"

/'
	Expected results:
		1) compile as part of fbc-tests through unit-tests.mk
		2) reported as success by fbcunit unit testing framework
'/

SUITE( fbc_tests.pretest.compile_with_fbcunit )
	TEST( test_true )
		CU_ASSERT_TRUE( -1 )
	END_TEST
END_SUITE
