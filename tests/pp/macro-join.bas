#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_join )

	TEST( direct )
		
		CU_ASSERT_EQUAL( __FB_JOIN__(1,2), 12 )
		CU_ASSERT_EQUAL( __FB_JOIN__( 1, 2 ), 12 )
		CU_ASSERT_EQUAL( __FB_JOIN__( 1, __FB_JOIN__( 2, 3 )), 123 )
		CU_ASSERT_EQUAL( __FB_JOIN__( __FB_JOIN__( 1, 2 ), 3 ), 123 )

	END_TEST

	TEST( defs )
		
		#define A 1
		#define B 2
		#define C 3

		CU_ASSERT_EQUAL( __FB_JOIN__(A,B), 12 )
		CU_ASSERT_EQUAL( __FB_JOIN__( A, B ), 12 )
		CU_ASSERT_EQUAL( __FB_JOIN__( A, __FB_JOIN__( B, C )), 123 )
		CU_ASSERT_EQUAL( __FB_JOIN__( __FB_JOIN__( A, B ), C ), 123 )

	END_TEST

	TEST( nested )
		
		#define M(A,B) __FB_JOIN__(A,B)

		CU_ASSERT_EQUAL( __FB_JOIN__(1,2), 12 )
		CU_ASSERT_EQUAL( __FB_JOIN__( 1, 2 ), 12 )
		CU_ASSERT_EQUAL( __FB_JOIN__( 1, __FB_JOIN__( 2, 3 )), 123 )
		CU_ASSERT_EQUAL( __FB_JOIN__( __FB_JOIN__( 1, 2 ), 3 ), 123 )

	END_TEST

	TEST( nested_defs )

		#define M(A,B) __FB_JOIN__(A,B)
		#define A 1
		#define B 2
		#define C 3

		CU_ASSERT_EQUAL( M(A,B), 12 )
		CU_ASSERT_EQUAL( M( A, B ), 12 )
		CU_ASSERT_EQUAL( M( A, M( B, C )), 123 )
		CU_ASSERT_EQUAL( M( M( A, B ), C ), 123 )

	END_TEST
 
END_SUITE
