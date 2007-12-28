# include "fbcu.bi"

namespace fbc_tests.structs.obj_global

const ARRAY_LB = 0
const ARRAY_UB = 3

type bar
    as integer v = any
    declare constructor
    declare destructor
end type

constructor bar
	static as integer cnt = 0
	cnt += 1
	v = cnt
end constructor

destructor bar
	v = 0
end destructor

#macro test_array( array, baseidx )
	scope
		dim as integer i
		for i = ARRAY_LB to ARRAY_UB
			CU_ASSERT_EQUAL( array(i).v, 1 + baseidx + i )
		next
	end scope
#endmacro

	static shared as bar b_static(ARRAY_LB to ARRAY_UB)
	
sub test_static cdecl
	test_array( b_static, (((ARRAY_UB - ARRAY_LB)+1) * 0) )
end sub	

	dim shared as bar b_shared(ARRAY_LB to ARRAY_UB)
	
sub test_shared cdecl
	test_array( b_shared, (((ARRAY_UB - ARRAY_LB)+1) * 1) )
end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-structs:obj-global")
	fbcu.add_test( "test static", @test_static)
	fbcu.add_test( "test shared", @test_shared)

end sub
	
end namespace	