# include "fbcu.bi"

namespace fbc_tests.structs.bitfield_select

type ud  
   d:1 as uinteger 
end type 

type uc  
   c as ud 
end type 

type ub  
   b as uc ptr 
end type 

sub selectCaseTest cdecl ()
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
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.bitfield_select")
	fbcu.add_test("selectCaseTest", @selectCaseTest)

end sub

end namespace
