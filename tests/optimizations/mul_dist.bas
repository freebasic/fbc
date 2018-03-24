#include "fbcunit.bi"

#define expr(a,b,c) ( (a) - ( (b)+1 )*3 + (c) )

SUITE( fbc_tests.optimizations.mul_dist )

	TEST( distributive_multiplication )

		dim as integer a = 0, b = 0, c = 0

		CU_ASSERT_EQUAL( expr(0,0,0), -3 )
		CU_ASSERT_EQUAL( expr(a,b,c), expr(0,0,0) )

	END_TEST

END_SUITE
