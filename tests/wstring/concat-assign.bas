#include "fbcunit.bi"
#include "chk-wstring.bi"

SUITE( fbc_tests.wstring_.concat_assign )

	#macro check( len_a, len_b, count, s )
		scope
			dim a as wstring * len_a
			dim b as wstring * len_b = s
			dim r as wstring * 100
			for i as integer = 1 to count
				
				'' concat & assign
				a &= b

				'' concat, truncate, assign
				r = left( r & b, len_a - 1 )

				CU_ASSERT_WSTRING_EQUAL( a, r )
			next
		end scope
	#endmacro

	#macro check_6( len_b, count, s )
		check( 1, 2, 4, s )
		check( 2, 2, 4, s )
		check( 3, 2, 4, s )
		check( 4, 2, 4, s )
		check( 5, 2, 4, s )
		check( 6, 2, 4, s )
	#endmacro

	TEST( default )
		
		'' strings converted to wstring
		check( 1, 1, 1, "a" )
		check( 1, 1, 2, "a" )

		check_6( 2, 4, "a" )
		check_6( 3, 4, "ab" )

		check_6( 4, 4, "ab" )
		check_6( 5, 4, "ab" )

		check_6( 4, 4, "abc" )
		check_6( 5, 4, "abc" )

		'' wstrings
		check( 1, 1, 1, !"\u3041" )
		check( 1, 1, 2, !"\u3041" )

		check_6( 2, 4, !"\u3041" )
		check_6( 3, 4, !"\u3041\u3043" )

		check_6( 4, 4, !"\u3041\u3043" )
		check_6( 5, 4, !"\u3041\u3043" )

		check_6( 4, 4, !"\u3041\u3043\u3045" )
		check_6( 5, 4, !"\u3041\u3043\u3045" )
	END_TEST

END_SUITE
