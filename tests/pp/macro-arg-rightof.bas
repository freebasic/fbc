#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_arg_rightof )

	TEST( direct )

		CU_ASSERT_EQUAL( __FB_ARG_RIGHTOF__( 1 2, 1 ), 2 )
		CU_ASSERT_EQUAL( __FB_ARG_RIGHTOF__( 1 2 3, 2 ), 3 )
		CU_ASSERT_EQUAL( __FB_ARG_RIGHTOF__( 1 TO 2, TO ), 2 )

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

	END_TEST

END_SUITE
 
