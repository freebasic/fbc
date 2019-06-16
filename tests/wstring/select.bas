#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.select_ )

	#macro check( expr, literal, is_match )
		scope
			dim w as wstring * 50 = expr
			
			select case w
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

			dim pw as wstring ptr = strptr( w )
			select case *pw
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
			
			select case w
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

			dim pw as wstring ptr = strptr( w )
			select case *pw
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

	TEST( default )

		dim w as wstring * 10 => "abc"
			
		select case w
		case "1" to "10"
			CU_ASSERT( 0 )
		
		case "def"		
			CU_ASSERT( 0 )
		
		case "abc"
			CU_ASSERT( -1 )
			
		case else
			CU_ASSERT( 0 )	
		
		end select

	END_TEST

END_SUITE
