#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_arg_rightof )

	TEST( direct )

		CU_ASSERT_EQUAL( __FB_ARG_RIGHTOF__( 1 2, 1 ), 2 )
		CU_ASSERT_EQUAL( __FB_ARG_RIGHTOF__( 1 2 3, 2 ), 3 )
		CU_ASSERT_EQUAL( __FB_ARG_RIGHTOF__( 1 TO 2, TO ), 2 )

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_ARG_RIGHTOF__( 1 2, not-there ) ) , "" )
		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_ARG_RIGHTOF__( 1 2, not-there, x ) ) , "x" )

	END_TEST

	TEST( defs )
		
		#define A 1
		#define B 2
		#define C 3
		#define X 12
		#define E 1 TO 2
		#define F TO

		CU_ASSERT_EQUAL( __FB_ARG_RIGHTOF__( A B, A ), B )
		CU_ASSERT_EQUAL( __FB_ARG_RIGHTOF__( X C, X ), C )
		CU_ASSERT_EQUAL( __FB_ARG_RIGHTOF__( E, F ), B )

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_ARG_RIGHTOF__( A B, C ) ), "" )
		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_ARG_RIGHTOF__( A B, C, X ) ), "12" )

		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_ARG_RIGHTOF__( X C, B ) ), "" )
		CU_ASSERT_EQUAL( __FB_QUOTE__( __FB_ARG_RIGHTOF__( X C, B, A ) ), "1" )

	END_TEST

END_SUITE
 
