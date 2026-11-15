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

	'' WSTRING function results and concatenations in the true/false
	'' expressions are temporary wstrings, deleted after they were copied
	'' into the iif() result: only in the code path that was executed
	dim shared as wstring * 50 buff

	function wref( ) byref as wstring
		return buff
	end function

	TEST( functionResults )

		dim as wstring * 50 a, e

		buff = !"  aぁb  "

		for n as integer = 0 to 2
			a = iif( n = 0, trim( buff ), left( trim( buff ), n ) )
			select case n
			case 0 : e = !"aぁb"
			case 1 : e = "a"
			case 2 : e = !"aぁ"
			end select
			CU_ASSERT_WSTRING_EQUAL( a, e )

			a = iif( n = 1, trim( buff ) & "!" & ltrim( buff ), rtrim( wref( ) ) )
			e = iif( n = 1, !"aぁb!aぁb  ", !"  aぁb" )
			CU_ASSERT_WSTRING_EQUAL( a, e )

			a = "x" & iif( n = 0, iif( n = 1, rtrim( buff ), ltrim( buff ) ), trim( wref( ) ) & "?" )
			e = iif( n = 0, !"xaぁb  ", !"xaぁb?" )
			CU_ASSERT_WSTRING_EQUAL( a, e )

			a = iif( n = 2, wref( ), wstr( "q" ) & trim( buff ) )
			e = iif( n = 2, !"  aぁb  ", !"qaぁb" )
			CU_ASSERT_WSTRING_EQUAL( a, e )

			select case iif( n = 2, trim( buff ), wstr( "q" ) & trim( buff ) )
			case !"aぁb"
				CU_ASSERT( n = 2 )
			case !"qaぁb"
				CU_ASSERT( n <> 2 )
			case else
				CU_FAIL( )
			end select

			select case trim( buff ) & "!"
			case !"aぁb!"
				CU_PASS( )
			case else
				CU_FAIL( )
			end select
		next

	END_TEST

END_SUITE
