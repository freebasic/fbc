#include "fbcunit.bi"
#include once "uwstring-fixed.bi"
#include once "chk-wstring.bi"

#define ustring UWSTRING_FIXED

SUITE( fbc_tests.udt_wstring_.case_ )

	'' U/LCASE( wstring )
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
		check( !"\u30a1\u30a3\u30a5\u30a7\u30a9" )       '' katakana
		check( !"\u0444\u044b\u0432\u0430\u043f\u0440" ) '' russian
		check( !"asd wstring fghjkl\u4644" )
		check( "QWERTZUIOP" )
		check( "1234567890" )
	END_TEST

END_SUITE
