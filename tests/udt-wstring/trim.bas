#include "fbcunit.bi"
#include once "uwstring-fixed.bi"
#include once "chk-wstring.bi"

#define ustring UWSTRING_FIXED

SUITE( fbc_tests.udt_wstring_.trim_ )

	'' L/R/TRIM( wstring )
	#macro check_rtlfunc( rtlfunc, text )
		scope
			dim t as wstring * 50 = text
			dim u as ustring = t

			CU_ASSERT( t = text )
			CU_ASSERT( u = t )

			dim rt as wstring * 50 = rtlfunc( t )
			dim ru as wstring * 50 = rtlfunc( u )
			CU_ASSERT_WSTRING_EQUAL( rt, ru )

		end scope
	#endmacro

	'' L/R/TRIM( wstring, pattern )
	#macro check_rtlfunc_filter( rtlfunc, text, pattern )
		scope
			dim t as wstring * 50 = text
			dim u as ustring = t

			CU_ASSERT( t = text )
			CU_ASSERT( u = t )

			dim tf as wstring * 50 = pattern
			dim uf as ustring = tf

			'' wstring, udt
			scope
				dim rt as wstring * 50 = rtlfunc( t, tf )
				dim ru as wstring * 50 = rtlfunc( t, uf )
				CU_ASSERT_WSTRING_EQUAL( rt, ru )
			end scope

			'' udt, wstring
			scope
				dim rt as wstring * 50 = rtlfunc( t, tf )
				dim ru as wstring * 50 = rtlfunc( u, tf )
				CU_ASSERT_WSTRING_EQUAL( rt, ru )
			end scope

			'' udt, udt
			scope
				dim rt as wstring * 50 = rtlfunc( t, tf )
				dim ru as wstring * 50 = rtlfunc( u, uf )
				CU_ASSERT_WSTRING_EQUAL( rt, ru )
			end scope

		end scope
	#endmacro

	'' L/R/TRIM( wstring, any pattern )
	#macro check_rtlfunc_any( rtlfunc, text, pattern )
		scope
			dim t as wstring * 50 = text
			dim u as ustring = t

			CU_ASSERT( t = text )
			CU_ASSERT( u = t )

			dim tf as wstring * 50 = pattern
			dim uf as ustring = tf

			'' wstring, udt
			scope
				dim rt as wstring * 50 = rtlfunc( t, any tf )
				dim ru as wstring * 50 = rtlfunc( t, any uf )
				CU_ASSERT_WSTRING_EQUAL( rt, ru )
			end scope

			'' udt, wstring
			scope
				dim rt as wstring * 50 = rtlfunc( t, any tf )
				dim ru as wstring * 50 = rtlfunc( u, any tf )
				CU_ASSERT_WSTRING_EQUAL( rt, ru )
			end scope

			'' udt, udt
			scope
				dim rt as wstring * 50 = rtlfunc( t, any tf )
				dim ru as wstring * 50 = rtlfunc( u, any uf )
				CU_ASSERT_WSTRING_EQUAL( rt, ru )
			end scope

		end scope
	#endmacro

	#macro check( text )
		check_rtlfunc( ltrim, text )
		check_rtlfunc( rtrim, text )
		check_rtlfunc( trim, text )
	#endmacro

	#macro check_filter( text, pattern )
		check_rtlfunc_filter( ltrim, text, pattern )
		check_rtlfunc_filter( rtrim, text, pattern )
		check_rtlfunc_filter( trim, text, pattern )
	#endmacro

	#macro check_any( text, pattern )
		check_rtlfunc_any( ltrim, text, pattern )
		check_rtlfunc_any( rtrim, text, pattern )
		check_rtlfunc_any( trim, text, pattern )
	#endmacro


	TEST( default )
		check( "" )
		check( " " )
		check( "  " )
		check( "abcde" )
		check( "  abcde" )
		check( "abcde  " )
		check( "  abcde  " )
		check( !"\u3041\u3043\u3045\u3047\u3049" )
		check( !"  \u3041\u3043\u3045\u3047\u3049" )
		check( !"\u3041\u3043\u3045\u3047\u3049  " )
		check( !"  \u3041\u3043\u3045\u3047\u3049  " )

		check_filter( "", "" )
		check_filter( "", " " )
		check_filter( " ", "" )
		check_filter( " ", " " )
		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041" )
		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3041" )
		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3049" )
		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3049\u3047" )
		check_filter( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3049" )

		check_any( "", "" )
		check_any( "", " " )
		check_any( " ", "" )
		check_any( " ", " " )
		check_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041" )
		check_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3043" )
		check_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3043\u3041" )
		check_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3049" )
		check_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3047\u3049" )
		check_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3049\u3047" )
		check_any( !"\u3041\u3043\u3045\u3047\u3049", !"\u3041\u3049" )

	END_TEST

END_SUITE
