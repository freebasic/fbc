#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_iif )

	TEST( direct )
		
		CU_ASSERT_EQUAL( __FB_IIF__( 0, 1, 2), 2 )
		CU_ASSERT_EQUAL( __FB_IIF__(-1, 1, 2), 1 )
		CU_ASSERT_EQUAL( __FB_IIF__( 1, 1, 2), 1 )
		
	END_TEST

	TEST( expr )
		
		#define A 1
		#define B 2
		#define C 3

		CU_ASSERT_EQUAL( __FB_IIF__( A    , 1, 2), 1 )
		CU_ASSERT_EQUAL( __FB_IIF__( A+B  , 1, 2), 1 )
		CU_ASSERT_EQUAL( __FB_IIF__( C-B-A, 1, 2), 2 )

	END_TEST

END_SUITE
