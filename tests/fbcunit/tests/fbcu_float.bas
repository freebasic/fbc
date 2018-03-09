#include once "fbcunit.bi"

SUITE( floating_point )

	TEST( single_exact )
		dim a as single = 1.0!
		dim b as single = 1.0!
		CU_ASSERT_SINGLE_EXACT( a, b )
	END_TEST

	TEST( single_equal )
		dim a as single = 1.0000000!
		dim b as single = 1.0000001!
		dim e as single = 0.0000005!
		CU_ASSERT_SINGLE_EQUAL( a, b, e )
	END_TEST

	TEST( single_approx )
		dim a as single = 1.0000000!
		dim b as single = 1.0000001!
		dim ulps as long = 1
		CU_ASSERT( fbcu.sngIsNan( a ) = false )
		CU_ASSERT( fbcu.sngIsInf( a ) = false )
		CU_ASSERT( fbcu.sngULPdiff( a, b ) = ulps )
		CU_ASSERT_SINGLE_APPROX( a, b, ulps )
		CU_ASSERT_SINGLE_APPROX( a, a - fbcu.sngULP(a), ulps )
		CU_ASSERT_SINGLE_APPROX( a, a + fbcu.sngULP(a) * 2, ulps )
	END_TEST

	TEST( double_exact )
		dim a as double = 1.0#
		dim b as double = 1.0#
		CU_ASSERT_DOUBLE_EXACT( a, b )
	END_TEST

	TEST( double_equal )
		dim a as double = 1.000000000000000#
		dim b as double = 1.000000000000001#
		dim e as double = 0.000000000000005#
		CU_ASSERT_DOUBLE_EQUAL( a, b, e )
	END_TEST

	TEST( double_approx )
		dim a as double = 1.0000000000000000#
		dim b as double = 1.0000000000000002#
		dim ulps as longint = 1
		CU_ASSERT( fbcu.dblIsNan( a ) = false )
		CU_ASSERT( fbcu.dblIsInf( a ) = false )
		CU_ASSERT( fbcu.dblULPdiff( a, b ) = ulps )
		CU_ASSERT_DOUBLE_APPROX( a, b, ulps )
		CU_ASSERT_DOUBLE_APPROX( a, a - fbcu.dblULP(a), ulps )
		CU_ASSERT_DOUBLE_APPROX( a, a + fbcu.dblULP(a), ulps )
	END_TEST

END_SUITE
