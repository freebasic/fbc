# include "fbcu.bi"

namespace fbc_tests.structs.obj_property2

type bar
    declare property v as integer
    declare property v ( new_v as integer )

    as integer p_v = 1
end type

property bar.v as integer
	property = p_v
end property

property bar.v ( new_v as integer)
	'' note: the property get will be called here
	p_v += v
end property

sub test cdecl
	dim as bar b1
	
	b1.v = 1
	CU_ASSERT_EQUAL( b1.v, 1+1 )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.obj_property2")
	fbcu.add_test( "test", @test)

end sub
	
end namespace	