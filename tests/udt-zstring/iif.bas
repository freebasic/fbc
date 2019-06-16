#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.iif_ )

	#macro check_zstring( expr, true_expr, false_expr )
		scope
			dim t1 as zstring * 50 = true_expr
			dim t2 as zstring * 50 = false_expr

			dim u1 as ustring = true_expr
			dim u2 as ustring = false_expr

			'' ZSTRING = iif( expr, LITERAL1, LITERAL2 )
			scope
				dim a as zstring * 50 = iif( expr, true_expr, false_expr )
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( a, t2 )
				endif
			end scope

			'' ZSTRING = iif( expr, ZSTRING1, LITERAL2 )
			scope
				dim a as zstring * 50 = iif( expr, t1, false_expr )
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( a, t2 )
				endif
			end scope

			'' ZSTRING = iif( expr, LITERAL1, ZSTRING2 )
			scope
				dim a as zstring * 50 = iif( expr, true_expr, t2 )
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( a, t2 )
				endif
			end scope

			'' ZSTRING = iif( expr, ZSTRING1, ZSTRING2 )
			scope
				dim a as zstring * 50 = iif( expr, t1, t2 )
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( a, t2 )
				endif
			end scope

			'' ZSTRING = iif( expr, USTRING1, LITERAL2 )
			scope
				dim a as zstring * 50 = iif( expr, u1, false_expr )
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( a, t2 )
				endif
			end scope

			'' ZSTRING = iif( expr, LITERAL1, USTRING2 )
			scope
				dim a as zstring * 50 = iif( expr, true_expr, u2 )
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( a, t2 )
				endif
			end scope

			'' ZSTRING = iif( expr, USTRING1, USTRING2 )
			scope
				dim a as zstring * 50 = iif( expr, u1, u2 )
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( a, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( a, t2 )
				endif
			end scope
		end scope
	#endmacro

	#macro check_ustring( expr, true_expr, false_expr )
		scope
			dim t1 as zstring * 50 = true_expr
			dim t2 as zstring * 50 = false_expr

			dim u1 as ustring = true_expr
			dim u2 as ustring = false_expr

			'' USTRING = iif( expr, LITERAL1, LITERAL2 )
			scope
				dim a as ustring = iif( expr, true_expr, false_expr )
				dim r as zstring * 50 = a
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( r, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( r, t2 )
				endif
			end scope

			'' USTRING = iif( expr, ZSTRING1, LITERAL2 )
			scope
				dim a as ustring = iif( expr, t1, false_expr )
				dim r as zstring * 50 = a
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( r, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( r, t2 )
				endif
			end scope

			'' USTRING = iif( expr, LITERAL1, ZSTRING2 )
			scope
				dim a as ustring = iif( expr, true_expr, t2 )
				dim r as zstring * 50 = a
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( r, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( r, t2 )
				endif
			end scope

			'' USTRING = iif( expr, ZSTRING1, ZSTRING2 )
			scope
				dim a as ustring = iif( expr, t1, t2 )
				dim r as zstring * 50 = a
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( r, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( r, t2 )
				endif
			end scope

			'' USTRING = iif( expr, USTRING1, LITERAL2 )
			scope
				dim a as ustring = iif( expr, u1, false_expr )
				dim r as zstring * 50 = a
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( r, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( r, t2 )
				endif
			end scope

			'' USTRING = iif( expr, LITERAL1, USTRING2 )
			scope
				dim a as ustring = iif( expr, true_expr, u2 )
				dim r as zstring * 50 = a
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( r, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( r, t2 )
				endif
			end scope

			'' USTRING = iif( expr, USTRING1, USTRING2 )
			scope
				dim a as ustring = iif( expr, u1, u2 )
				dim r as zstring * 50 = a
				if( expr ) then
					CU_ASSERT_ZSTRING_EQUAL( r, t1 )
				else
					CU_ASSERT_ZSTRING_EQUAL( r, t2 )
				endif
			end scope

		end scope
	#endmacro

	TEST( zstring_iif )
		
		check_zstring(  0, "", "a" )
		check_zstring( -1, "", "a" )

		check_zstring(  0, "a", "xyz" )
		check_zstring( -1, "a", "xyz" )

	END_TEST

	TEST( ustring_iif )
		
		check_ustring(  0, "", "a" )
		check_ustring( -1, "", "a" )

		check_ustring(  0, "a", "xyz" )
		check_ustring( -1, "a", "xyz" )

	END_TEST

END_SUITE
