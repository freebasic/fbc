#include "fbcunit.bi"
#include once "chk-wstring.bi"

SUITE( fbc_tests.wstring_.swap_ )

	#macro check( literal1, literal2 )
		scope
			dim w1 as wstring * 50 = literal1
			dim w2 as wstring * 50 = literal2

			dim t1 as wstring * 50 = literal1
			dim t2 as wstring * 50 = literal2

			CU_ASSERT_WSTRING_EQUAL( w1, t1 )
			CU_ASSERT_WSTRING_EQUAL( w2, t2 )

			swap w1, w2

			CU_ASSERT_WSTRING_EQUAL( w1, t2 )
			CU_ASSERT_WSTRING_EQUAL( w2, t1 )

			swap w2, w1

			CU_ASSERT_WSTRING_EQUAL( w1, t1 )
			CU_ASSERT_WSTRING_EQUAL( w2, t2 )
		end scope
	#endmacro

	TEST( default )
		check( "", "" )

		check( "", "a" )
		check( "a", "a" )
		check( "a", "abcdefghi" )

		check( "", !"\u3041\u3043\u3045\u3047\u3049" )
		check( "abc", !"\u3041\u3043\u3045\u3047\u3049" )
		check( !"\u3045", !"\u3041\u3043\u3047\u3049" )

	END_TEST

END_SUITE
