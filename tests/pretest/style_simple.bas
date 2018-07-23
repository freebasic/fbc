' TEST_MODE : FBCUNIT_COMPATIBLE

#include "fbcunit.bi"

/'
	This style of test is the simplest and in common
	use throughout the test suite.

	The suite name typically has the form:
''	  SUITE( fbc_tests.<PATHNAME>.<FILENAME> )

	The names of the tests should be meaningful.  If you
	find tests where they are not, e.g. test1...test#, 
	consider providing a more descriptive name.
'/

SUITE( fbc_tests.pretest.style_simple )

	TEST( assert_const_true )
		CU_ASSERT_TRUE( -1 )
	END_TEST

	TEST( assert_const_false )
		CU_ASSERT_FALSE( 0 )
	END_TEST

	TEST( always_pass )
		CU_PASS()
	END_TEST

END_SUITE
