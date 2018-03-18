#include "fbcunit.bi"

SUITE( fbc_tests.wstrings.select_ )

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
