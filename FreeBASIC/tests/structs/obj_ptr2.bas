
# include "fbcu.bi"

namespace fbc_tests.structs.obj_ptr2

type foo
	as integer value = any
	as integer pad = any
	declare constructor( byval v as integer = 0 )
	declare destructor( )
end type

constructor foo( byval v as integer )
	static as integer cnt = 0
	value = cnt + v
	cnt += 1
end constructor

destructor foo()
	value = 1234
end destructor

function array_len as integer
	static as integer cnt = 10
	function = cnt
	cnt = -cnt
end function

sub test_1 cdecl	
	'' side-effect
	dim as foo ptr pf = new foo[array_len()]
	
	for i as integer = 0 to 9
		CU_ASSERT_EQUAL( pf[i].value, i )
	next
	
	delete[] pf
end sub
	
function array_idx as integer
	static as integer cnt = 1
	function = cnt
	cnt = -cnt
end function

sub test_2 cdecl	
	dim as foo ptr pf(0 to 1) = { NULL, new foo( -10 ) }
	
	CU_ASSERT_EQUAL( pf(1)->value, 0 )
	
	'' side-effect
	delete pf(array_idx())
end sub
	
private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-ptr2")
	fbcu.add_test( "1", @test_1)
	fbcu.add_test( "2", @test_2)

end sub
	
end namespace