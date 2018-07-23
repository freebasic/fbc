# include once "fbcunit.bi"

SUITE( fbc_tests.expressions.double_to_single )

	const EPSILON_SNG as single = 1.1929093e-7
	const EPSILON_DBL as double = 2.2204460492503131e-016

	TEST( doubleToSingle1 )
		'' overflows to 0
		#define N 4.940656458412465e-324

		dim d as double
		dim f as single

		d = N
		f = d

		CU_ASSERT( abs( d - N ) < EPSILON_DBL )
		CU_ASSERT( f = 0 )
		CU_ASSERT( csng( N ) = 0 )

		d = N
		CU_ASSERT( abs( d - N ) < EPSILON_DBL )

		d = csng( d )
		CU_ASSERT( d = 0 )
	END_TEST

	TEST( doubleToSingle2 )
		'' overflows to INF
		#define N 1.7976931348623147e+308

		dim as double d1, d2
		dim f1 as single

		d1 = N
		CU_ASSERT( abs( d1 - N ) < EPSILON_DBL )

		f1 = d1
		CU_ASSERT( f1 > d1 )
		CU_ASSERT( f1 > N )

		f1 = N
		CU_ASSERT( f1 > d1 )
		CU_ASSERT( f1 > N )

		d1 = N
		CU_ASSERT( abs( d1 - N ) < EPSILON_DBL )

		d2 = csng( d1 )
		CU_ASSERT( csng( d1 ) > d1 )
		CU_ASSERT( csng( N ) > N )
		CU_ASSERT( d2 = csng( d1 ) )

		d1 = N
		dim f2 as single = N
		CU_ASSERT( f2 > N )
		CU_ASSERT( f2 > d1 )

		d1 = N
		dim f3 as single = d1
		CU_ASSERT( f3 > N )
		CU_ASSERT( f3 > d1 )
	END_TEST

END_SUITE
