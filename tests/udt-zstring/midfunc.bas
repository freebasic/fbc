#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.midfunc )

	'' MID( wstring, start )
	#macro check( text, start, expected )
		scope
			dim st as zstring * 50 = text
			dim se as zstring * 50 = expected
			dim ut as ustring = st

			CU_ASSERT( st = text )
			CU_ASSERT( ut = st )

			dim rt as zstring * 50 = mid( st, start )
			dim ru as wstring * 50 = mid( ut, start )
			
			CU_ASSERT_ZSTRING_EQUAL( rt, ru )
			CU_ASSERT_ZSTRING_EQUAL( rt, se )
			CU_ASSERT_ZSTRING_EQUAL( ru, se )
		end scope
	#endmacro

	'' MID( wstring, start, length )
	#macro check_i_n( text, start, length, expected )
		scope
			dim st as zstring * 50 = text
			dim se as zstring * 50 = expected
			dim ut as ustring = st

			CU_ASSERT( st = text )
			CU_ASSERT( ut = st )

			dim rt as zstring * 50 = mid( st, start, length )
			dim ru as wstring * 50 = mid( ut, start, length )
			
			CU_ASSERT_ZSTRING_EQUAL( rt, ru )
			CU_ASSERT_ZSTRING_EQUAL( rt, se )
			CU_ASSERT_ZSTRING_EQUAL( ru, se )
		end scope
	#endmacro

	TEST( default )
		check( ""       , -1, "" )
		check( ""       ,  0, "" )
		check( ""       ,  1, "" )

		check( "a"      , -1, "" )
		check( "a"      ,  0, "" )
		check( "a"      ,  1, "a" )
		check( "a"      ,  2, "" )

		check( "ab"     , -1, "" )
		check( "ab"     ,  0, "" )
		check( "ab"     ,  1, "ab" )
		check( "ab"     ,  2, "b" )
		check( "ab"     ,  3, "" )

		check( "abc"    , -1, "" )
		check( "abc"    ,  0, "" )
		check( "abc"    ,  1, "abc" )
		check( "abc"    ,  2, "bc" )
		check( "abc"    ,  3, "c" )
		check( "abc"    ,  4, "" )

	END_TEST

	TEST( length )
		check_i_n( ""       , -1, -1, "" )
		check_i_n( ""       , -1,  0, "" )
		check_i_n( ""       , -1,  1, "" )

		check_i_n( ""       ,  0, -1, "" )
		check_i_n( ""       ,  0,  0, "" )
		check_i_n( ""       ,  0,  1, "" )

		check_i_n( ""       ,  1, -1, "" )
		check_i_n( ""       ,  1,  0, "" )
		check_i_n( ""       ,  1,  1, "" )

		check_i_n( "a"      , -1, -1, "" )
		check_i_n( "a"      , -1,  0, "" )
		check_i_n( "a"      , -1,  1, "" )
		check_i_n( "a"      , -1,  2, "" )

		check_i_n( "a"      ,  0, -1, "" )
		check_i_n( "a"      ,  0,  0, "" )
		check_i_n( "a"      ,  0,  1, "" )
		check_i_n( "a"      ,  0,  2, "" )

		check_i_n( "a"      ,  1, -1, "a" )
		check_i_n( "a"      ,  1,  0, "" )
		check_i_n( "a"      ,  1,  1, "a" )
		check_i_n( "a"      ,  1,  2, "a" )

		check_i_n( "a"      ,  2, -1, "" )
		check_i_n( "a"      ,  2,  0, "" )
		check_i_n( "a"      ,  2,  1, "" )
		check_i_n( "a"      ,  2,  2, "" )

		check_i_n( "ab"     ,  1, -2, "ab" )
		check_i_n( "ab"     ,  1, -1, "ab" )
		check_i_n( "ab"     ,  1,  0, "" )
		check_i_n( "ab"     ,  1,  1, "a" )
		check_i_n( "ab"     ,  1,  2, "ab" )
		check_i_n( "ab"     ,  1,  3, "ab" )

		check_i_n( "ab"     ,  2, -2, "b" )
		check_i_n( "ab"     ,  2, -1, "b" )
		check_i_n( "ab"     ,  2,  0, "" )
		check_i_n( "ab"     ,  2,  1, "b" )
		check_i_n( "ab"     ,  2,  2, "b" )
		check_i_n( "ab"     ,  2,  3, "b" )

		check_i_n( "ab"     ,  3, -2, "" )
		check_i_n( "ab"     ,  3, -1, "" )
		check_i_n( "ab"     ,  3,  0, "" )
		check_i_n( "ab"     ,  3,  1, "" )
		check_i_n( "ab"     ,  3,  2, "" )
		check_i_n( "ab"     ,  3,  3, "" )

	END_TEST


END_SUITE
