#include "fbcunit.bi"

#define NumList 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
#define GetNumList() NumList

SUITE( fbc_tests.pp.macro_arg_extract )

	TEST( direct )

		CU_ASSERT_EQUAL( 0, __FB_ARG_EXTRACT__( 0, NumList ) )
		CU_ASSERT_EQUAL( 1, __FB_ARG_EXTRACT__( 1, NumList ) )
		CU_ASSERT_EQUAL( 2, __FB_ARG_EXTRACT__( 2, NumList ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_EXTRACT__( 3, NumList ) )
		CU_ASSERT_EQUAL( 4, __FB_ARG_EXTRACT__( 4, NumList ) )
		CU_ASSERT_EQUAL( 5, __FB_ARG_EXTRACT__( 5, NumList ) )
		CU_ASSERT_EQUAL( 6, __FB_ARG_EXTRACT__( 6, NumList ) )
		CU_ASSERT_EQUAL( 7, __FB_ARG_EXTRACT__( 7, NumList ) )
		CU_ASSERT_EQUAL( 8, __FB_ARG_EXTRACT__( 8, NumList ) )
		CU_ASSERT_EQUAL( 9, __FB_ARG_EXTRACT__( 9, NumList ) )

	END_TEST

	TEST( indirect )

		CU_ASSERT_EQUAL( 0, __FB_ARG_EXTRACT__( 0, GetNumList() ) )
		CU_ASSERT_EQUAL( 1, __FB_ARG_EXTRACT__( 1, GetNumList() ) )
		CU_ASSERT_EQUAL( 2, __FB_ARG_EXTRACT__( 2, GetNumList() ) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_EXTRACT__( 3, GetNumList() ) )
		CU_ASSERT_EQUAL( 4, __FB_ARG_EXTRACT__( 4, GetNumList() ) )
		CU_ASSERT_EQUAL( 5, __FB_ARG_EXTRACT__( 5, GetNumList() ) )
		CU_ASSERT_EQUAL( 6, __FB_ARG_EXTRACT__( 6, GetNumList() ) )
		CU_ASSERT_EQUAL( 7, __FB_ARG_EXTRACT__( 7, GetNumList() ) )
		CU_ASSERT_EQUAL( 8, __FB_ARG_EXTRACT__( 8, GetNumList() ) )
		CU_ASSERT_EQUAL( 9, __FB_ARG_EXTRACT__( 9, GetNumList() ) )

	END_TEST

	TEST( empty_list )
		CU_ASSERT_EQUAL( "", __FB_QUOTE__( __FB_ARG_EXTRACT__( 0 ) ) )
		CU_ASSERT_EQUAL( "", __FB_QUOTE__( __FB_ARG_EXTRACT__( 0, ) ) )
		CU_ASSERT_EQUAL( "", __FB_QUOTE__( __FB_ARG_EXTRACT__( 1, ) ) )
		CU_ASSERT_EQUAL( "", __FB_QUOTE__( __FB_ARG_EXTRACT__( 0,, ) ) )
		CU_ASSERT_EQUAL( "", __FB_QUOTE__( __FB_ARG_EXTRACT__( 1,, ) ) )
		CU_ASSERT_EQUAL( "", __FB_QUOTE__( __FB_ARG_EXTRACT__( 2,, ) ) )
	END_TEST

	TEST( incorrect_indexes )
		CU_ASSERT_EQUAL( "", __FB_QUOTE__(__FB_ARG_EXTRACT__( 175, NumList ) ) )
		CU_ASSERT_EQUAL( "", __FB_QUOTE__(__FB_ARG_EXTRACT__( 99, NumList ) ) )
		CU_ASSERT_EQUAL( "", __FB_QUOTE__(__FB_ARG_EXTRACT__( 23, 9, 8, 7, 6, 5, 4, 3, 2, 1 ) ) )
	END_TEST

	TEST( literal_list )
		CU_ASSERT_EQUAL( 30, __FB_ARG_EXTRACT__(5, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50 ) )
		CU_ASSERT_EQUAL( 5, __FB_ARG_EXTRACT__(0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50 ) )
		CU_ASSERT_EQUAL( 45, __FB_ARG_EXTRACT__(8, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50 ) )
	END_TEST

	TEST( mixed_list )
		CU_ASSERT_EQUAL( 2, __FB_ARG_EXTRACT__(13, GetNumList(), 24.769, NumList) )
		CU_ASSERT_EQUAL( 3, __FB_ARG_EXTRACT__(5, 5, 10, NumList, 20, 25 ) )
		CU_ASSERT_EQUAL( 9, __FB_ARG_EXTRACT__(19, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, GetNumList() ) )
	END_TEST

	TEST( constructed_list )
		#define FLOAT_VAL 78.098
		#define CONCAT_INT(x, y...) x, y
		#define CONCAT(x, y...) CONcAT_INT(x, y)

		#define LIST1 9
		#define LIST2 CONCAT(LIST1, 4)
		#define LIST3 CONCAT(LIST2, FLOAT_VAL)
		#define LIST4 CONCAT(LIST3, "apple")
		#define LIST5 CONCAT(LIST4, "Postman")
		#define WHOLE_LIST CONCAT(LIST5, GetNumList())

		CU_ASSERT_EQUAL( "apple", __FB_ARG_EXTRACT__(3, WHOLE_LIST) )
		CU_ASSERT_EQUAL( 6, __FB_ARG_EXTRACT__(11, WHOLE_LIST) )
		CU_ASSERT_EQUAL( FLOAT_VAL, __FB_ARG_EXTRACT__(2, WHOLE_LIST) )
	END_TEST

	#macro nested1( n, arg0, arg1, arg3 )
		__FB_UNQUOTE__( "#define n1 " ) __FB_QUOTE__( arg1 )
	#endmacro

	#macro nestedX( n, args... )
		__FB_UNQUOTE__( "#define nx " ) __FB_QUOTE__( __FB_ARG_EXTRACT__( n, args ) )
	#endmacro

	#macro nestedreset
		__FB_UNQUOTE__( "#undef n1" )
		__FB_UNQUOTE__( "#undef nx" )
	#endmacro

	TEST( nested_comma_direct )

		scope
			dim a(0,0) as integer
			nested1( 1, 1, a(0,0), 3 )
			nestedX( 1, 1, a(0,0), 3 )
			CU_ASSERT_EQUAL( n1, nx )
			nestedreset
		end scope

		nested1( 1, 1, /'2,3'/, 3 )
		nestedX( 1, 1, /'2,3'/, 3 )
		CU_ASSERT_EQUAL( n1, __FB_QUOTE__(  ) )
		CU_ASSERT_EQUAL( n1, __FB_QUOTE__(  ) )
		nestedreset

		nested1( 1, 1, "2,3", 3 )
		nestedX( 1, 1, "2,3", 3 )
		CU_ASSERT_EQUAL( n1, __FB_QUOTE__( "2,3" ) )
		CU_ASSERT_EQUAL( nx, __FB_QUOTE__( "2,3" ) )
		nestedreset

		nested1( 1, 1, "2,(3", 3 )
		nestedX( 1, 1, "2,(3", 3 )
		CU_ASSERT_EQUAL( n1, __FB_QUOTE__( "2,(3" ) )
		CU_ASSERT_EQUAL( nx, __FB_QUOTE__( "2,(3" ) )
		nestedreset

		nested1( 1, 1, "2,""3", 3 )
		nestedX( 1, 1, "2,""3", 3 )
		CU_ASSERT_EQUAL( n1, __FB_QUOTE__( "2,""3" ) )
		CU_ASSERT_EQUAL( nx, __FB_QUOTE__( "2,""3" ) )
		nestedreset

		nested1( 1, 1, $"2,3", 3 )
		nestedX( 1, 1, $"2,3", 3 )
		CU_ASSERT_EQUAL( n1, __FB_QUOTE__( $"2,3" ) )
		CU_ASSERT_EQUAL( nx, __FB_QUOTE__( $"2,3" ) )
		nestedreset

		nested1( 1, 1, !"2,3", 3 )
		nestedX( 1, 1, !"2,3", 3 )
		CU_ASSERT_EQUAL( n1, __FB_QUOTE__( !"2,3" ) )
		CU_ASSERT_EQUAL( nx, __FB_QUOTE__( !"2,3" ) )
		nestedreset

		nested1( 1, 1, !"\\\"""2,3", 3 )
		nestedX( 1, 1, !"\\\"""2,3", 3 )
		CU_ASSERT_EQUAL( n1, __FB_QUOTE__( !"\\\"""2,3" ) )
		CU_ASSERT_EQUAL( nx, __FB_QUOTE__( !"\\\"""2,3" ) )
		nestedreset

	END_TEST

	#macro nested_test( arg )
		nested1( 1, 1, arg, 3 )
		nestedX( 1, 1, arg, 3 )
		CU_ASSERT_EQUAL( n1, __FB_QUOTE__( arg ) )
		CU_ASSERT_EQUAL( nx, __FB_QUOTE__( arg ) )
		nestedreset

	#endmacro

	TEST( nested_comma_indirect )

		nested_test( /' comment '/ )
		nested_test( () )
		nested_test( a(1,2) )
		nested_test( "2,3" )
		nested_test( "2,(3" )
		nested_test( "2,""3" )
		nested_test( "/' string '/" )
		nested_test( $"2,3" )
		nested_test( !"2,3" )
		nested_test( $"\\""""2,3" )
		nested_test( !"\\\"""2,3" )

	END_TEST

END_SUITE

