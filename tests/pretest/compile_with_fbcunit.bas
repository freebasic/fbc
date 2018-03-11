
' TEST_MODE : FBCUNIT_COMPATIBLE

#include "fbcunit.bi"

/'
	In current version of fbc test suite, FBCUNIT_COMPATIBLE
	test mode is optional.  unit-tests.mk will also search
	for #include "fbcunit.bi" as indicator that this is to
	built as part of fbc-tests.

	Expected results:
		1) compile as part of fbc-tests through unit-tests.mk
		2) reported as success by fbcunit unit testing framework
'/

SUITE( fbc_tests.pretest.compile_with_fbcunit )
	TEST( test_true )
		CU_ASSERT_TRUE( -1 )
	END_TEST
END_SUITE
