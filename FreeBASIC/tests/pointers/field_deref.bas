# include "fbcu.bi"

namespace fbc_tests.pointers.field_deref

	type a
	    as integer pad
	    as integer x
		as integer y    
	end type
	
	type b
	    as a ptr aPtr
	end type
	
sub test1 cdecl ()
	dim as a a1 = ( 0, 1234, 5678 )
	dim as b b1
	
	b1.aptr = @a1
	
	CU_ASSERT_EQUAL( (*b1.aptr).x, 1234 )
	CU_ASSERT_EQUAL( b1.aptr->y, 5678 )

end sub

sub test2 cdecl ()
	dim as a a1 = ( 0, -1234, -5678 )
	dim as a ptr pa1
	
	pa1 = @a1
	
	CU_ASSERT_EQUAL( (*pa1).x, -1234 )
	CU_ASSERT_EQUAL( pa1->y, -5678 )

end sub
	
private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.field_deref")
	fbcu.add_test("test1", @test1)
	fbcu.add_test("test2", @test2)

end sub

end namespace
	
	