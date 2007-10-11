# include "fbcu.bi"

namespace fbc_tests.structs.obj_property_stmt

type tfoo
    declare function fun () as integer
    pad as byte
end type

function tfoo.fun () as integer
    function = 1234
end function

type bar
    declare property foo () as tfoo
    pad as byte
end type

property bar.foo() as tfoo
    return type(1)
end property

sub test_1 cdecl
	dim b as bar

	CU_ASSERT_EQUAL( b.foo.fun(), 1234 )
	
	'' invoke the property get, not the set
	b.foo.fun()
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:property-stmt")
	fbcu.add_test( "#1", @test_1)

end sub
	
end namespace		