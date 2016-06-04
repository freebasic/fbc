# include "fbcu.bi"

namespace fbc_tests.struct.obj_meth_ovld_sub

type foo
	as integer sub_called = 0

	declare sub bar
	declare function bar( byval i as integer ) as integer
end type

sub foo.bar
	sub_called = -1
end sub

function foo.bar( byval i as integer ) as integer
	function = i
end function
	
sub test cdecl ()
	dim as foo f
	
	CU_ASSERT_EQUAL( f.bar( 1 ), 1 )
	
	f.bar 1
	
	f.bar
	
	CU_ASSERT( f.sub_called )
	
end sub
	
private sub ctor () constructor

	fbcu.add_suite("fbc_tests.structs.obj_meth_ovld_sub")
	fbcu.add_test("test", @test)
	
end sub

end namespace
	