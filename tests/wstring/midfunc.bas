#include "fbcunit.bi"
#include once "chk-wstring.bi"

SUITE( fbc_tests.wstring_.midfunc )

	#macro check( text, start, expected )
		scope
			dim wr as wstring * 50 = mid( wstr(text), start )
			dim we as wstring * 50 = wstr( expected )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
		end scope

		scope
			dim wt as wstring * 50 = wstr( text )
			dim we as wstring * 50 = wstr( expected )
			dim wr as wstring * 50 = mid( wt, start )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
		end scope
	#endmacro

	#macro check_i_n( text, start, length, expected )
		scope
			dim wr as wstring * 50 = mid( wstr(text), start, length )
			dim we as wstring * 50 = wstr( expected )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
		end scope

		scope
			dim wt as wstring * 50 = wstr( text )
			dim we as wstring * 50 = wstr( expected )
			dim wr as wstring * 50 = mid( wt, start, length )
			CU_ASSERT_WSTRING_EQUAL( wr, we )
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

		check( !"\u3041", -1, !"" )
		check( !"\u3041",  0, !"" )
		check( !"\u3041",  1, !"\u3041" )
		check( !"\u3041",  2, !"" )

		check( !"\u3041\u3043", -1, !"" )
		check( !"\u3041\u3043",  0, !"" )
		check( !"\u3041\u3043",  1, !"\u3041\u3043" )
		check( !"\u3041\u3043",  2, !"\u3043" )
		check( !"\u3041\u3043",  3, !"" )

		check( !"\u3041\u3043\u3045", -1, !"" )
		check( !"\u3041\u3043\u3045",  0, !"" )
		check( !"\u3041\u3043\u3045",  1, !"\u3041\u3043\u3045" )
		check( !"\u3041\u3043\u3045",  2, !"\u3043\u3045" )
		check( !"\u3041\u3043\u3045",  3, !"\u3045" )
		check( !"\u3041\u3043\u3045",  4, !"" )
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

		check_i_n( !"\u3041\u3043\u3045", -1, -2, !"" )
		check_i_n( !"\u3041\u3043\u3045", -1, -1, !"" )
		check_i_n( !"\u3041\u3043\u3045", -1,  0, !"" )
		check_i_n( !"\u3041\u3043\u3045", -1,  1, !"" )
		check_i_n( !"\u3041\u3043\u3045", -1,  2, !"" )
		check_i_n( !"\u3041\u3043\u3045", -1,  3, !"" )
		check_i_n( !"\u3041\u3043\u3045", -1,  4, !"" )

		check_i_n( !"\u3041\u3043\u3045",  0, -2, !"" )
		check_i_n( !"\u3041\u3043\u3045",  0, -1, !"" )
		check_i_n( !"\u3041\u3043\u3045",  0,  0, !"" )
		check_i_n( !"\u3041\u3043\u3045",  0,  1, !"" )
		check_i_n( !"\u3041\u3043\u3045",  0,  2, !"" )
		check_i_n( !"\u3041\u3043\u3045",  0,  3, !"" )
		check_i_n( !"\u3041\u3043\u3045",  0,  4, !"" )

		check_i_n( !"\u3041\u3043\u3045",  1, -2, !"\u3041\u3043\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  1, -1, !"\u3041\u3043\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  1,  0, !"" )
		check_i_n( !"\u3041\u3043\u3045",  1,  1, !"\u3041" )
		check_i_n( !"\u3041\u3043\u3045",  1,  2, !"\u3041\u3043" )
		check_i_n( !"\u3041\u3043\u3045",  1,  3, !"\u3041\u3043\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  1,  4, !"\u3041\u3043\u3045" )

		check_i_n( !"\u3041\u3043\u3045",  2, -2, !"\u3043\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  2, -1, !"\u3043\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  2,  0, !"" )
		check_i_n( !"\u3041\u3043\u3045",  2,  1, !"\u3043" )
		check_i_n( !"\u3041\u3043\u3045",  2,  2, !"\u3043\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  2,  3, !"\u3043\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  2,  4, !"\u3043\u3045" )

		check_i_n( !"\u3041\u3043\u3045",  3, -2, !"\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  3, -1, !"\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  3,  0, !"" )
		check_i_n( !"\u3041\u3043\u3045",  3,  1, !"\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  3,  2, !"\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  3,  3, !"\u3045" )
		check_i_n( !"\u3041\u3043\u3045",  3,  4, !"\u3045" )

		check_i_n( !"\u3041\u3043\u3045",  4, -1, !"" )
		check_i_n( !"\u3041\u3043\u3045",  4,  0, !"" )
		check_i_n( !"\u3041\u3043\u3045",  4,  1, !"" )
		check_i_n( !"\u3041\u3043\u3045",  4,  2, !"" )
		check_i_n( !"\u3041\u3043\u3045",  4,  3, !"" )
		check_i_n( !"\u3041\u3043\u3045",  4,  4, !"" )

	END_TEST


END_SUITE
