# include "fbcu.bi"

namespace fbc_tests.functions.bydesc_array_str

const ARRAY_LB = 0
const ARRAY_UB = 9

'':::::	
sub dotest ( array() as string )
	dim as integer i
	
	for i = ARRAY_LB to ARRAY_UB
		CU_ASSERT( array(i) = str(i) )
	next
	
end sub

sub dotest_pre ( array() as string )
	dotest( array() )	
end sub

sub fillarray ( array() as string )
	dim as integer i
	
	for i = ARRAY_LB to ARRAY_UB
		array(i) = str(i)
	next
	
end sub

sub test_loc cdecl ()

	redim as string loc_arr(ARRAY_LB to ARRAY_UB)
	
	fillarray( loc_arr() )
	dotest( loc_arr() )

end sub

	dim shared as string glob_arr(ARRAY_LB to ARRAY_UB)
	
sub test_glob cdecl ()

	fillarray( glob_arr() )
	dotest( glob_arr() )

end sub

sub test_param cdecl ()

	fillarray( glob_arr() )
	dotest_pre( glob_arr() )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.bydesc_array_str")
	fbcu.add_test("local array", @test_loc)
	fbcu.add_test("global array", @test_glob)
	fbcu.add_test("param array", @test_param)

end sub

end namespace
