#include "fbcunit.bi"

SUITE( fbc_tests.structs.bitfield_select )

	type ud  
	   d:1 as uinteger 
	end type 

	type uc  
	   c as ud 
	end type 

	type ub  
	   b as uc ptr 
	end type 

	TEST( selectCase )
		dim a as ub ptr 

		a = callocate( len( ub ) ) 
		a->b = callocate( len( uc ) ) 
		
		CU_ASSERT_EQUAL( a->b->c.d, 0 )
		a->b->c.d = 1 
		CU_ASSERT_EQUAL( a->b->c.d, 1 )
		
		select case a->b->c.d 
		case 0
			CU_ASSERT( 0 )
		case 1
			'ok
		case else
			CU_ASSERT( 0 )
		end select
		
		deallocate a->b 
		deallocate a
	END_TEST

END_SUITE
