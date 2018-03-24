#include "fbcunit.bi"

SUITE( fbc_tests.pointers.field_deref )

	type a
	    as integer pad
	    as integer x
		as integer y    
	end type
	
	type b
	    as a ptr aPtr
	end type
	
	TEST( derefUDT )
		dim as a a1 = ( 0, 1234, 5678 )
		dim as b b1
		
		b1.aptr = @a1
		
		CU_ASSERT_EQUAL( (*b1.aptr).x, 1234 )
		CU_ASSERT_EQUAL( b1.aptr->y, 5678 )

	END_TEST

	TEST( derefUDTfield )
		dim as a a1 = ( 0, -1234, -5678 )
		dim as a ptr pa1
		
		pa1 = @a1
		
		CU_ASSERT_EQUAL( (*pa1).x, -1234 )
		CU_ASSERT_EQUAL( pa1->y, -5678 )

	END_TEST
		
END_SUITE
