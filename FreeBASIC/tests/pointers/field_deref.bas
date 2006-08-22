# include "fbcu.bi"

namespace fbc_tests.pointers.field_deref

	type a
	    as integer x
		as integer y    
	end type
	
	type b
	    as a ptr aPtr
	end type
	
sub test cdecl ()
	dim as a a1 = ( 1234, 5678 )
	dim as b b1
	
	b1.aptr = @a1
	
	CU_ASSERT_EQUAL( (*b1.aptr).x, 1234 )
	CU_ASSERT_EQUAL( b1.aptr->y, 5678 )

end sub
	
private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.field_deref")
	fbcu.add_test("test", @test)

end sub

end namespace
	
	