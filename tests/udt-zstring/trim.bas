#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.trim_ )

	'' L/R/TRIM( zstring )
	#macro check_rtlfunc( rtlfunc, text )
		scope
			dim t as zstring * 50 = text
			dim u as ustring = t

			CU_ASSERT( t = text )
			CU_ASSERT( u = t )

			dim rt as zstring * 50 = rtlfunc( t )
			dim ru as zstring * 50 = rtlfunc( u )
			CU_ASSERT_ZSTRING_EQUAL( rt, ru )

		end scope
	#endmacro

	'' L/R/TRIM( zstring, pattern )
	#macro check_rtlfunc_filter( rtlfunc, text, pattern )
		scope
			dim t as zstring * 50 = text
			dim u as ustring = t

			CU_ASSERT( t = text )
			CU_ASSERT( u = t )

			dim tf as zstring * 50 = pattern
			dim uf as ustring = tf

			'' zstring, udt
			scope
				dim rt as zstring * 50 = rtlfunc( t, tf )
				dim ru as zstring * 50 = rtlfunc( t, uf )
				CU_ASSERT_ZSTRING_EQUAL( rt, ru )
			end scope

			'' udt, zstring
			scope
				dim rt as zstring * 50 = rtlfunc( t, tf )
				dim ru as zstring * 50 = rtlfunc( u, tf )
				CU_ASSERT_ZSTRING_EQUAL( rt, ru )
			end scope

			'' udt, udt
			scope
				dim rt as zstring * 50 = rtlfunc( t, tf )
				dim ru as zstring * 50 = rtlfunc( u, uf )
				CU_ASSERT_ZSTRING_EQUAL( rt, ru )
			end scope

		end scope
	#endmacro

	'' L/R/TRIM( zstring, any pattern )
	#macro check_rtlfunc_any( rtlfunc, text, pattern )
		scope
			dim t as zstring * 50 = text
			dim u as ustring = t

			CU_ASSERT( t = text )
			CU_ASSERT( u = t )

			dim tf as zstring * 50 = pattern
			dim uf as ustring = tf

			'' zstring, udt
			scope
				dim rt as zstring * 50 = rtlfunc( t, any tf )
				dim ru as zstring * 50 = rtlfunc( t, any uf )
				CU_ASSERT_ZSTRING_EQUAL( rt, ru )
			end scope

			'' udt, zstring
			scope
				dim rt as zstring * 50 = rtlfunc( t, any tf )
				dim ru as zstring * 50 = rtlfunc( u, any tf )
				CU_ASSERT_ZSTRING_EQUAL( rt, ru )
			end scope

			'' udt, udt
			scope
				dim rt as zstring * 50 = rtlfunc( t, any tf )
				dim ru as zstring * 50 = rtlfunc( u, any uf )
				CU_ASSERT_ZSTRING_EQUAL( rt, ru )
			end scope

		end scope
	#endmacro

	#macro check( s )
		check_rtlfunc( ltrim, s )
		check_rtlfunc( rtrim, s )
		check_rtlfunc( trim, s )
	#endmacro

	#macro check_filter( s, f )
		check_rtlfunc_filter( ltrim, s, f )
		check_rtlfunc_filter( rtrim, s, f )
		check_rtlfunc_filter( trim, s, f )
	#endmacro

	#macro check_any( s, f )
		check_rtlfunc_any( ltrim, s, f )
		check_rtlfunc_any( rtrim, s, f )
		check_rtlfunc_any( trim, s, f )
	#endmacro

	TEST( default )
		check( "" )
		check( " " )
		check( "  " )
		check( "abcde" )
		check( "  abcde" )
		check( "abcde  " )
		check( "  abcde  " )

		check_filter( "", "" )
		check_filter( "", " " )
		check_filter( " ", "" )
		check_filter( " ", " " )
		check_filter( "abcde", "a" )
		check_filter( "abcde", "ab" )
		check_filter( "abcde", "ba" )
		check_filter( "abcde", "e" )
		check_filter( "abcde", "de" )
		check_filter( "abcde", "ed" )
		check_filter( "abcde", "ae" )


		check_any( "", "" )
		check_any( "", " " )
		check_any( " ", "" )
		check_any( " ", " " )
		check_any( "abcde", "a" )
		check_any( "abcde", "ab" )
		check_any( "abcde", "ba" )
		check_any( "abcde", "e" )
		check_any( "abcde", "de" )
		check_any( "abcde", "ed" )
		check_any( "abcde", "ae" )

	END_TEST

END_SUITE
