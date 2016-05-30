# include "fbcu.bi"

namespace fbc_tests.pointers.ptrToFuncArray

const TEST_VAL = &hdeadbeef

type fn as function(byval as integer, byval as integer, byval as integer) as integer ptr
	
function func(byval a as integer, byval b as integer, byval c as integer) as integer ptr

	static test as integer = TEST_VAL
	function = @test

end function
	
	dim shared fnarray(10) as fn ptr

	dim shared i as integer = 5
	dim shared j as integer = 3
	
sub test cdecl ()

	CU_ASSERT_EQUAL( *fnarray(i)[j]( 1, 2, 3 ), TEST_VAL )

end sub

function init cdecl () as long
	fnarray(i) = allocate((j + 1) * sizeof(fn ptr))
	if (0 = fnarray(i)) then
		return -1
	end if
	
	fnarray(i)[j] = @func
	return 0
end function

function cleanup cdecl () as long
	deallocate(fnarray(i))
	return 0
end function

sub ctor () constructor
	fbcu.add_suite("fbc_tests.pointers.array_ptr_fn", @init, @cleanup)
	fbcu.add_test("test", @test)
end sub

end namespace
