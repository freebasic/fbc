#include "fbcunit.bi"
#include once "uwstring-fixed.bi"
#include once "chk-wstring.bi"

#define ustring UWSTRING_FIXED

SUITE( fbc_tests.udt_wstring_.left_ )

	'' LEFT( wstring, length )
	#macro check_rtlfunc( rtlfunc, s, n )
		scope
			dim t as wstring * 50 = s
			dim u as ustring = t

			CU_ASSERT( t = s )
			CU_ASSERT( u = t )

			dim rt as wstring * 50 = rtlfunc( t, n )
			dim ru as wstring * 50 = rtlfunc( u, n )
			CU_ASSERT_WSTRING_EQUAL( rt, ru )

		end scope
	#endmacro

	#macro check( s )
		for i as integer = -1 to len( s ) + 1
			check_rtlfunc( left, s, i )
			check_rtlfunc( right, s, i )
		next
	#endmacro

	TEST( default )

		check( "" )
		check( " " )
		check( "abcde" )
		check( !"\u30a1\u30a3\u30a5\u30a7\u30a9" )       '' katakana
		check( !"\u0444\u044b\u0432\u0430\u043f\u0440" ) '' russian
		check( !"asd wstring fghjkl\u4644" )
		check( "1234567890" )
	END_TEST

END_SUITE
