#include "fbcunit.bi"

SUITE( fbc_tests.pp.macro_arg_count )

	TEST( direct )
		CU_ASSERT_EQUAL( 0, __FB_ARG_COUNT__( ) )
		CU_ASSERT_EQUAL( 1, __FB_ARG_COUNT__( 1 ) )
		CU_ASSERT_EQUAL( 2, __FB_ARG_COUNT__( 1, 2 ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_COUNT__( 1, 2, 3 ) )
		CU_ASSERT_EQUAL( 2, __FB_ARG_COUNT__( , ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_COUNT__( ,, ) )
		CU_ASSERT_EQUAL( 2, __FB_ARG_COUNT__( 1, ) )
		CU_ASSERT_EQUAL( 2, __FB_ARG_COUNT__( ,2 ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_COUNT__( ,, ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_COUNT__( 1,, ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_COUNT__( ,2, ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_COUNT__( ,,3 ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_COUNT__( 1,2, ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_COUNT__( 1,,3 ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_COUNT__( ,2,3 ) )
	END_TEST


	#define df0()     __FB_ARG_COUNT__()
	#define df1(a)    __FB_ARG_COUNT__(a)
	#define df2(a,b)  __FB_ARG_COUNT__(a,b)

	TEST( define_fixed )
		CU_ASSERT_EQUAL( 0, df0() )
		CU_ASSERT_EQUAL( 1, df1(1) )
		CU_ASSERT_EQUAL( 2, df2(1,2) )
	END_TEST

	#macro mf0()
		__FB_ARG_COUNT__()
	#endmacro

	#macro mf1(a)
		__FB_ARG_COUNT__(a)
	#endmacro

	#macro mf2(a,b)
		__FB_ARG_COUNT__(a,b)
	#endmacro

	TEST( macro_fixed )
		CU_ASSERT_EQUAL( 0, df0() )
		CU_ASSERT_EQUAL( 1, df1(1) )
		CU_ASSERT_EQUAL( 2, df2(1,2) )
	END_TEST


	dim shared check_count as integer = 0	

	#macro chk0( args... )
		CU_ASSERT_EQUAL( check_count,  __FB_ARG_COUNT__(args) )
	#endmacro

	TEST( vararg0 )

		check_count = 0
			chk0( )

		check_count = 1
			chk0( 1 )

		check_count = 2
			chk0( 1, 2 )
			chk0( 1,   )
			chk0(  , 2 )
			chk0(  ,   )

		check_count = 3
			chk0( 1, 2, 3 )
			chk0( 1,  ,   )
			chk0(  , 2,   )
			chk0(  ,  , 3 )
			chk0( 1, 2,   )
			chk0( 1,  , 3 )
			chk0(  , 2, 3 )
			chk0(  ,  ,   )

	END_TEST
	
	#macro chk1( a, args... )
		CU_ASSERT_EQUAL( check_count,  __FB_ARG_COUNT__(args) )
	#endmacro

	TEST( vararg1 )

		check_count = 0
			chk1( -1 )

		check_count = 1
			chk1( -1, 1 )

		check_count = 2
			chk1( -1, 1, 2 )
			chk1( -1, 1,   )
			chk1( -1,  , 2 )
			chk1( -1,  ,   )

		check_count = 3
			chk1( -1, 1, 2, 3 )
			chk1( -1, 1,  ,   )
			chk1( -1,  , 2,   )
			chk1( -1,  ,  , 3 )
			chk1( -1, 1, 2,   )
			chk1( -1, 1,  , 3 )
			chk1( -1,  , 2, 3 )
			chk1( -1,  ,  ,   )

	END_TEST

	#macro chk2( a, b, args... )
		CU_ASSERT_EQUAL( check_count,  __FB_ARG_COUNT__(args) )
	#endmacro

	TEST( vararg2 )

		check_count = 0
			chk2( -2, -1 )

		check_count = 1
			chk2( -2, -1, 1 )

		check_count = 2
			chk2( -2, -1, 1, 2 )
			chk2( -2, -1, 1,   )
			chk2( -2, -1,  , 2 )
			chk2( -2, -1,  ,   )

		check_count = 3
			chk2( -2, -1, 1, 2, 3 )
			chk2( -2, -1, 1,  ,   )
			chk2( -2, -1,  , 2,   )
			chk2( -2, -1,  ,  , 3 )
			chk2( -2, -1, 1, 2,   )
			chk2( -2, -1, 1,  , 3 )
			chk2( -2, -1,  , 2, 3 )
			chk2( -2, -1,  ,  ,   )

	END_TEST

	#macro n_chk0( expr... )
		chk0( expr )
	#endmacro

	TEST( nested0 )

		check_count = 0
			n_chk0( )

		check_count = 1
			n_chk0( 1 )

		check_count = 2
			n_chk0( 1, 2 )
			n_chk0( 1,   )
			n_chk0(  , 2 )
			n_chk0(  ,   )

		check_count = 3
			n_chk0( 1, 2, 3 )
			n_chk0( 1,  ,   )
			n_chk0(  , 2,   )
			n_chk0(  ,  , 3 )
			n_chk0( 1, 2,   )
			n_chk0( 1,  , 3 )
			n_chk0(  , 2, 3 )
			n_chk0(  ,  ,   )

	END_TEST

	#macro n_chk1( x, expr... )
		chk1( x, expr )
	#endmacro

	TEST( nested1 )

		check_count = 0
			n_chk1( -1 )

		check_count = 1
			n_chk1( -1, 1 )

		check_count = 2
			n_chk1( -1, 1, 2 )
			n_chk1( -1, 1,   )
			n_chk1( -1,  , 2 )
			n_chk1( -1,  ,   )

		check_count = 3
			n_chk1( -1, 1, 2, 3 )
			n_chk1( -1, 1,  ,   )
			n_chk1( -1,  , 2,   )
			n_chk1( -1,  ,  , 3 )
			n_chk1( -1, 1, 2,   )
			n_chk1( -1, 1,  , 3 )
			n_chk1( -1,  , 2, 3 )
			n_chk1( -1,  ,  ,   )

	END_TEST

	#macro n_chk2( x, y, expr... )
		chk2( x, y, expr )
	#endmacro

	TEST( nested2 )

		check_count = 0
			n_chk2( -2, -1 )

		check_count = 1
			n_chk2( -2, -1, 1 )

		check_count = 2
			n_chk2( -2, -1, 1, 2 )
			n_chk2( -2, -1, 1,   )
			n_chk2( -2, -1,  , 2 )
			n_chk2( -2, -1,  ,   )

		check_count = 3
			n_chk2( -2, -1, 1, 2, 3 )
			n_chk2( -2, -1, 1,  ,   )
			n_chk2( -2, -1,  , 2,   )
			n_chk2( -2, -1,  ,  , 3 )
			n_chk2( -2, -1, 1, 2,   )
			n_chk2( -2, -1, 1,  , 3 )
			n_chk2( -2, -1,  , 2, 3 )
			n_chk2( -2, -1,  ,  ,   )

	END_TEST


END_SUITE
 
