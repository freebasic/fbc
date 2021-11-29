#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.left_ )

	'' LEFT( zstring, length )
	#macro check_rtlfunc( rtlfunc, s, n )
		scope
			dim t as zstring * 50 = s
			dim u as ustring = t

			CU_ASSERT( t = s )
			CU_ASSERT( u = t )

			dim rt as zstring * 50 = rtlfunc( t, n )
			dim ru as zstring * 50 = rtlfunc( u, n )
			CU_ASSERT_ZSTRING_EQUAL( rt, ru )

		end scope
	#endmacro

	#macro check( s )
		for i as integer = -1 to len( s ) + 1
			check_rtlfunc( left, s, i )
			check_rtlfunc( right, s, i )
		next
	#endmacro

'' left and right functions are not overloaded to accept a BYREF as ZSTRING

	TEST( default )

		check( "" )
		check( " " )
		check( "abcde" )
		check( "1234567890" )
	END_TEST

END_SUITE
