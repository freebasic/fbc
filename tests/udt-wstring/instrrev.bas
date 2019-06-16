#include "fbcunit.bi"
#include once "uwstring-fixed.bi"
#include once "chk-wstring.bi"

#define ustring UWSTRING_FIXED

SUITE( fbc_tests.udt_wstring_.instrrev_ )

	'' INSTRREV( wstring, wstring )
	#macro check_0( result, text, pattern )
		scope
			dim st as wstring * 50 = text
			dim ut as ustring = st
			dim sp as wstring * 50 = pattern
			dim up as ustring = sp
			
			CU_ASSERT_EQUAL( result, instrrev( st, sp ) )
			CU_ASSERT_EQUAL( result, instrrev( st, up ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, sp ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, up ) )
		end scope
	#endmacro

		'' INSTRREV( index, wstring, wstring )
	#macro check_x( result, index, text, pattern )
		scope
			dim st as wstring * 50 = text
			dim ut as ustring = st
			dim sp as wstring * 50 = pattern
			dim up as ustring = sp
			
			CU_ASSERT_EQUAL( result, instrrev( st, sp, index ) )
			CU_ASSERT_EQUAL( result, instrrev( st, up, index ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, sp, index ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, up, index ) )
		end scope
	#endmacro

		'' INSTRREV( wstring, wstring )
	#macro check_0_any( result, text, pattern )
		scope
			dim st as wstring * 50 = text
			dim ut as ustring = st
			dim sp as wstring * 50 = pattern
			dim up as ustring = sp
			
			CU_ASSERT_EQUAL( result, instrrev( st, any sp ) )
			CU_ASSERT_EQUAL( result, instrrev( st, any up ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, any sp ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, any up ) )
		end scope
	#endmacro

		'' INSTRREV( index, wstring, wstring )
	#macro check_x_any( result, index, text, pattern )
		scope
			dim st as wstring * 50 = text
			dim ut as ustring = st
			dim sp as wstring * 50 = pattern
			dim up as ustring = sp
			
			CU_ASSERT_EQUAL( result, instrrev( st, any sp, index ) )
			CU_ASSERT_EQUAL( result, instrrev( st, any up, index ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, any sp, index ) )
			CU_ASSERT_EQUAL( result, instrrev( ut, any up, index ) )
		end scope
	#endmacro

	TEST( instrrev_0 )
		check_0( 0, !"", !"" )
		check_0( 0, !"x", !"" )
		check_0( 0, !"", !"x" )
		check_0( 1, !"x", !"x" )
		check_0( 2, !"yx", !"x" )

		check_0( 1, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_0( 2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )
		check_0( 3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )
		check_0( 4, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
	END_TEST

	TEST( instrrev_x )
		check_x( 0, -2, !"", !"" )
		check_x( 0, -1, !"", !"" )
		check_x( 0,  0, !"", !"" )
		check_x( 0,  1, !"", !"" )
		check_x( 0,  2, !"", !"" )

		check_x( 0, -2, !"x", !"" )
		check_x( 0, -1, !"x", !"" )
		check_x( 0,  0, !"x", !"" )
		check_x( 0,  1, !"x", !"" )
		check_x( 0,  2, !"x", !"" )

		check_x( 0, -2, !"", !"x" )
		check_x( 0, -1, !"", !"x" )
		check_x( 0,  0, !"", !"x" )
		check_x( 0,  1, !"", !"x" )
		check_x( 0,  2, !"", !"x" )

		check_x( 1, -2, !"x", !"x" )
		check_x( 1, -1, !"x", !"x" )
		check_x( 0,  0, !"x", !"x" )
		check_x( 1,  1, !"x", !"x" )
		check_x( 0,  2, !"x", !"x" )
		check_x( 0,  3, !"x", !"x" )

		check_x( 1, -2, !"xy", !"x" )
		check_x( 1, -1, !"xy", !"x" )
		check_x( 0,  0, !"xy", !"x" )
		check_x( 1,  1, !"xy", !"x" )
		check_x( 1,  2, !"xy", !"x" )
		check_x( 0,  3, !"xy", !"x" )

		check_x( 2, -2, !"yx", !"x" )
		check_x( 2, -1, !"yx", !"x" )
		check_x( 0,  0, !"yx", !"x" )
		check_x( 0,  1, !"yx", !"x" )
		check_x( 2,  2, !"yx", !"x" )
		check_x( 0,  3, !"yx", !"x" )

		check_x( 1, -1, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_x( 0,  0, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_x( 1,  1, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_x( 1,  2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )

		check_x( 0,  1, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )
		check_x( 2,  2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )
		check_x( 2,  3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )

		check_x( 0,  2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )
		check_x( 3,  3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )
		check_x( 3,  4, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )

		check_x( 0,  3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
		check_x( 4,  4, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
		check_x( 4,  5, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
		check_x( 0,  6, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
	END_TEST

	TEST( instrrev_0_any )
		check_0_any( 0, !"", !"" )
		check_0_any( 0, !"x", !"" )
		check_0_any( 0, !"", !"x" )
		check_0_any( 1, !"x", !"x" )
		check_0_any( 1, !"xy", !"x" )
		check_0_any( 2, !"yx", !"x" )

		check_0_any( 2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_0_any( 3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )
		check_0_any( 4, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )
		check_0_any( 5, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )

		check_0_any( 2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3041" )
		check_0_any( 3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3043" )
		check_0_any( 4, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3045" )
		check_0_any( 5, !"\u3041\u3043\u3045\u3047\u3049", !"\u3049\u3047" )
	END_TEST

	TEST( instrrev_x_any )
		check_x_any( 0, -2, !"", !"" )
		check_x_any( 0, -1, !"", !"" )
		check_x_any( 0,  0, !"", !"" )
		check_x_any( 0,  1, !"", !"" )
		check_x_any( 0,  2, !"", !"" )

		check_x_any( 0, -2, !"x", !"" )
		check_x_any( 0, -1, !"x", !"" )
		check_x_any( 0,  0, !"x", !"" )
		check_x_any( 0,  1, !"x", !"" )
		check_x_any( 0,  2, !"x", !"" )

		check_x_any( 0, -2, !"", !"x" )
		check_x_any( 0, -1, !"", !"x" )
		check_x_any( 0,  0, !"", !"x" )
		check_x_any( 0,  1, !"", !"x" )
		check_x_any( 0,  2, !"", !"x" )

		check_x_any( 1, -2, !"x", !"x" )
		check_x_any( 1, -1, !"x", !"x" )
		check_x_any( 0,  0, !"x", !"x" )
		check_x_any( 1,  1, !"x", !"x" )
		check_x_any( 0,  2, !"x", !"x" )

		check_x_any( 1, -2, !"xy", !"x" )
		check_x_any( 1, -1, !"xy", !"x" )
		check_x_any( 0,  0, !"xy", !"x" )
		check_x_any( 1,  1, !"xy", !"x" )
		check_x_any( 1,  2, !"xy", !"x" )
		check_x_any( 0,  3, !"xy", !"x" )

		check_x_any( 2, -2, !"yx", !"x" )
		check_x_any( 2, -1, !"yx", !"x" )
		check_x_any( 0,  0, !"yx", !"x" )
		check_x_any( 0,  1, !"yx", !"x" )
		check_x_any( 2,  2, !"yx", !"x" )
		check_x_any( 0,  3, !"yx", !"x" )

		check_x_any( 0,  0, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_x_any( 1,  1, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_x_any( 2,  2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_x_any( 2,  3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )

		check_x_any( 0,  0, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )
		check_x_any( 0,  1, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )
		check_x_any( 2,  2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )
		check_x_any( 3,  3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )
		check_x_any( 3,  4, !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3045" )

		check_x_any( 0,  1, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )
		check_x_any( 0,  2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )
		check_x_any( 3,  3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )
		check_x_any( 4,  4, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )
		check_x_any( 4,  5, !"\u3041\u3043\u3045\u3047\u3049", !"\u3045\u3047" )

		check_x_any( 0,  2, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
		check_x_any( 0,  3, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
		check_x_any( 4,  4, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
		check_x_any( 5,  5, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
		check_x_any( 0,  6, !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
	END_TEST

END_SUITE
