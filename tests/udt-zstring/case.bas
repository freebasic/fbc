#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.case_ )

	'' U/LCASE( zstring )
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

	#macro check( text )
		check_rtlfunc( ucase, text )
		check_rtlfunc( lcase, text )
	#endmacro

	TEST( default )
		check( "" )
		check( " " )
		check( "  " )
		check( "abcde" )
		check( "asdfghjkl" )
		check( "QWERTZUIOP" )
		check( "1234567890" )
	END_TEST

END_SUITE
