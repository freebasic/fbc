# include "fbcu.bi"

namespace fbc_tests.functions.bydesc_array

const ARRAY_LB = 0
const ARRAY_UB = 9

'':::::	
sub dotest ( array() as integer )
	dim as integer i
	
	for i = ARRAY_LB to ARRAY_UB
		CU_ASSERT( array(i) = i )
	next
	
end sub

sub dotest_pre ( array() as integer )
	dotest( array() )	
end sub

sub fillarray ( array() as integer )
	dim as integer i
	
	for i = ARRAY_LB to ARRAY_UB
		array(i) = i
	next
	
end sub

sub test_loc cdecl ()

	redim as integer loc_arr(ARRAY_LB to ARRAY_UB)
	
	fillarray( loc_arr() )
	dotest( loc_arr() )

end sub

	dim shared as integer glob_arr(ARRAY_LB to ARRAY_UB)
	
sub test_glob cdecl ()

	fillarray( glob_arr() )
	dotest( glob_arr() )

end sub

sub test_param cdecl ()

	fillarray( glob_arr() )
	dotest_pre( glob_arr() )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.bydesc_array")
	fbcu.add_test("local array", @test_loc)
	fbcu.add_test("global array", @test_glob)
	fbcu.add_test("param array", @test_param)

end sub

end namespace
