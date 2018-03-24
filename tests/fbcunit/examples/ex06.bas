/'
	fbcunit example #6

		- test usage in -lang qb
'/

'$lang: "qb"

option explicit
'$include: "fbcunit.bi"

SUITE( qb )

	TEST( qb )
		CU_ASSERT( 1 )
		CU_ASSERT( -1 )
		CU_ASSERT_TRUE( 1 )
		CU_ASSERT_TRUE( -1 )
		CU_ASSERT_FALSE( 0 )
		CU_ASSERT_NOT_EQUAL( 0, 1 )
	END_TEST

	TEST( qb_single )
		dim n as single
		dim x as single
		dim b as single
		dim g as single
		dim c as single
		dim u as long

		n = 1.0!
		x = 1.0!

		CU_ASSERT_SINGLE_EXACT( n, x )

		n = 1.0000000!
		b = 1.0000001!
		g = 0.0000005!

		CU_ASSERT_SINGLE_EQUAL( n, b, g )

		n = 1.0000000!
		c = 1.0000001!
		u = 1

		CU_ASSERT( fbcu.sngIsNan( n ) = false )
		CU_ASSERT( fbcu.sngIsInf( n ) = false )
		CU_ASSERT( fbcu.sngULPdiff( n, c ) = u )
		CU_ASSERT_SINGLE_APPROX( n, c, u )

	END_TEST

	TEST( qb_double )
		
		dim n as double
		dim x as double
		dim b as double
		dim g as double
		dim c as double
		dim u as __longint

		n = 1.0#
		x = 1.0#

		CU_ASSERT_DOUBLE_EXACT( n, x )

		n = 1.000000000000000#
		b = 1.000000000000001#
		g = 0.000000000000005#

		CU_ASSERT_DOUBLE_EQUAL( n, b, g )

		n = 1.0000000000000000#
		c = 1.0000000000000002#
		u = 1

		CU_ASSERT( fbcu.dblIsNan( n ) = false )
		CU_ASSERT( fbcu.dblIsInf( n ) = false )
		CU_ASSERT( fbcu.dblULPdiff( n, c ) = u )
		CU_ASSERT_DOUBLE_APPROX( n, c, u )
		
	END_TEST

END_SUITE

fbcu.run_tests
