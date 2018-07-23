#include "fbcunit.bi"

#define expr(n) ((n - (n - (n + (n - (n + 1))))))

SUITE( fbc_tests.optimizations.addsub )

	TEST( constantFoldingExpressions )
		dim as integer n = 0
		CU_ASSERT_EQUAL( expr(0), -1 )
		CU_ASSERT_EQUAL( expr(n), expr(0) )

		dim as integer i = 0
		CU_ASSERT( (i - (i+1) * 2 + i) = -2 )
		i = 10
		CU_ASSERT( (i - (i+1) * 2 + i) = -2 )
		i = -99
		CU_ASSERT( (i - (i+1) * 2 + i) = -2 )
	END_TEST

END_SUITE
