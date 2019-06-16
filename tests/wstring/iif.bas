#include "fbcunit.bi"
#include once "chk-wstring.bi"

SUITE( fbc_tests.wstring_.iif_ )

	#macro check( expr, true_expr, false_expr )
		scope
			dim t1 as wstring * 50 = true_expr
			dim t2 as wstring * 50 = false_expr

			scope
				dim a as wstring * 50 = iif( expr, true_expr, false_expr )
				if( expr ) then
					CU_ASSERT_WSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_WSTRING_EQUAL( a, t2 )
				endif
			end scope

			scope
				dim a as wstring * 50 = iif( expr, t1, false_expr )
				if( expr ) then
					CU_ASSERT_WSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_WSTRING_EQUAL( a, t2 )
				endif
			end scope

			scope
				dim a as wstring * 50 = iif( expr, true_expr, t2 )
				if( expr ) then
					CU_ASSERT_WSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_WSTRING_EQUAL( a, t2 )
				endif
			end scope

			scope
				dim a as wstring * 50 = iif( expr, t1, t2 )
				if( expr ) then
					CU_ASSERT_WSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_WSTRING_EQUAL( a, t2 )
				endif
			end scope

		end scope
	#endmacro

	TEST( default )
		
		check(  0, "", "a" )
		check( -1, "", "a" )

		check(  0, "a", "xyz" )
		check( -1, "a", "xyz" )

		check(  0, !"\u3041\u3043\u3045", "a" )
		check( -1, !"\u3041\u3043\u3045", "a" )

		check(  0, "a", !"\u3041\u3043\u3045" )
		check( -1, "a", !"\u3041\u3043\u3045" )

		check(  0, !"\u3047", !"\u3041\u3043\u3045" )
		check( -1, !"\u3047", !"\u3041\u3043\u3045" )

	END_TEST

END_SUITE
