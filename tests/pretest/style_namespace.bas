' TEST_MODE : FBCUNIT_COMPATIBLE

#include "fbcunit.bi"

/'
	This style of test uses namespaces to isolate
	types and variables from other tests, yet still
	exist within a single SUITE().

	The suite name typically has the form:
''	  SUITE( fbc_tests.<PATHNAME>.<FILENAME> )

	The namespaces used are not reported in the
	fbc-tests report.  There may be cases in the
	existing test suite where the namespace is
	descriptive, but the test name is not.  If
	you find any of these cases, please consider
	rewriting to the style shown here.
'/

SUITE( fbc_tests.pretest.style_namespace )

	TEST_GROUP( ns1 )

		const x = -1

		TEST( x_is_true )
			CU_ASSERT_TRUE( x )
		END_TEST

	END_TEST_GROUP

	TEST_GROUP( ns2 )

		const x = 0

		TEST( x_is_false )
			CU_ASSERT_FALSE( x )
		END_TEST

	END_TEST_GROUP

END_SUITE
