#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.logic1 )
	
	TEST( test1 )
		if( 0 )then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	END_TEST
	
	TEST( test2 )
		if( 1 and 0 )then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	END_TEST
	
	TEST( test3 )
		if( 1 > 0 and 0 ) then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	END_TEST
	
	TEST( test4 )
		dim as string source = "this is a test"
		if len(source) > 0 and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if ( len(source) > 0 ) and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	END_TEST
	
	TEST( test5 )
		dim A as string
		A = "test 1..2..3..4...5..6...7..8...9..10"
		if len(A) > 15 and 0 then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if ( len(A) > 15 ) and 0 then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	END_TEST
	
	TEST( test6 )
		dim as integer a
		if ( a + 0 ) then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	END_TEST

	TEST( test7 )
		const a = iif( 1, 123, 456 )
		const b = iif( 0, 123, 456 )
		CU_ASSERT( a = 123 )
		CU_ASSERT( b = 456 )

		dim as integer x = 321
		CU_ASSERT( iif( 1, x, 0 ) = x )
		CU_ASSERT( iif( 0, 0, x ) = x )
	END_TEST

END_SUITE
