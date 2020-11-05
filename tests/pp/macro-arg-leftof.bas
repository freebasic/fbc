#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_arg_leftof )

	TEST( direct )

		CU_ASSERT_EQUAL( __FB_ARG_LEFTOF__( 1 2, 2 ), 1 )
		CU_ASSERT_EQUAL( __FB_ARG_LEFTOF__( 1 2 3, 2 ), 1 )
		CU_ASSERT_EQUAL( __FB_ARG_LEFTOF__( 1 TO 2, TO ), 1 )

	END_TEST

	TEST( defs )
		
		#define A 1
		#define B 2
		#define C 3
		#define X 12
		#define E 1 TO 2
		#define F TO

		CU_ASSERT_EQUAL( __FB_ARG_LEFTOF__( A B, B ), A )
		CU_ASSERT_EQUAL( __FB_ARG_LEFTOF__( X C, C ), X )
		CU_ASSERT_EQUAL( __FB_ARG_LEFTOF__( E, F ), A )

	END_TEST

END_SUITE

