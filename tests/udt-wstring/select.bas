#include "fbcunit.bi"
#include once "uwstring-fixed.bi"
#include once "chk-wstring.bi"

#define ustring UWSTRING_FIXED

SUITE( fbc_tests.udt_wstring_.select_ )

	#macro check( expr, literal, is_match )
		scope
			dim w as wstring * 50 = expr
			dim u as ustring = w
			
			select case u
			case literal
				if( is_match ) then
					CU_PASS()
				else
					CU_FAIL()
				end if
			case else
				if( is_match ) then
					CU_FAIL()
				else
					CU_PASS()
				end if
			end select
		end scope
	#endmacro

	#macro check_range( expr, literal1, literal2, is_match )
		scope
			dim w as wstring * 50 = expr
			dim u as ustring = w
			
			select case u
			case literal1 to literal2
				if( is_match ) then
					CU_PASS()
				else
					CU_FAIL()
				end if
			case else
				if( is_match ) then
					CU_FAIL()
				else
					CU_PASS()
				end if
			end select
		end scope
	#endmacro

	TEST( ucs2 )
		check( !"\u3041", !"\u3041", true )
		check( !"\u3041", !"\u3043", false )
		check( !"a\u3041b", !"a\u3041b", true )
		check( !"a\u3041b", !"ab", false )
		check( !"\u3041\u3043\u3045\u3047\u3049", _ )
		       !"\u3041\u3043\u3045\u3047\u3049", true )
		check( !"\u3041\u3043\u3045\u3047\u3049", _ )
		       !"\u3041\u3043\u3045\u3047", false )

		dim arg as wstring * 50 = !"\u3041\u3043\u3045\u3047\u3049"
		check( left( arg, 0 ), "", true )
		check( left( arg, 1 ), !"\u3041", true )
		check( left( arg, 2 ), !"\u3041\u3043", true )
		check( left( arg, 3 ), !"\u3041\u3043\u3045", true )

		check( right( arg, 0 ), "", true )
		check( right( arg, 1 ), !"\u3049", true )
		check( right( arg, 2 ), !"\u3047\u3049", true )
		check( right( arg, 3 ), !"\u3045\u3047\u3049", true )

		check( mid( arg, 2 ), !"\u3043\u3045\u3047\u3049", true )
		check( mid( arg, 3 ), !"\u3045\u3047\u3049", true )
		check( mid( arg, 4 ), !"\u3047\u3049", true )
		check( mid( arg, 5 ), !"\u3049", true )

		check_range( !"\u3043\u3045\u3047\u3049", !"\u3041", !"\u3045", true )
		check_range( !"\u3047\u3049", !"\u3041", !"\u3045", false )
	END_TEST

	TEST( ascii )
		check( "0123456789", "0123456789", true )
		check( "0123456789", "012345678", false )
		check( "abc", "abc", true )
		check( "abc", "ABC", false )

		dim arg as wstring * 50 = "abcdefghij"
		check( left( arg, 0 ), "", true )
		check( left( arg, 1 ), "a", true )
		check( left( arg, 2 ), "ab", true )
		check( left( arg, 3 ), "abc", true )

		check( right( arg, 0 ), "", true )
		check( right( arg, 1 ), "j", true )
		check( right( arg, 2 ), "ij", true )
		check( right( arg, 3 ), "hij", true )

		check( mid( arg, 2 ), "bcdefghij", true )
		check( mid( arg, 3 ), "cdefghij", true )
		check( mid( arg, 4 ), "defghij", true )
		check( mid( arg, 5 ), "efghij", true )

		check_range( "bcd", "b", "c", true )
		check_range( "xyz", "b", "c", false )
	END_TEST

END_SUITE
 
