#include "fbcunit.bi"
#include once "uzstring-fixed.bi"
#include once "chk-zstring.bi"

#define ustring UZSTRING_FIXED

SUITE( fbc_tests.udt_zstring_.select_ )

	#macro check( expr, literal, is_match )
		scope
			dim w as zstring * 50 = expr
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
			dim w as zstring * 50 = expr
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

	TEST( ascii )
		check( "0123456789", "0123456789", true )
		check( "0123456789", "012345678", false )
		check( "abc", "abc", true )
		check( "abc", "ABC", false )

		dim arg as zstring * 50 = "abcdefghij"
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
 
