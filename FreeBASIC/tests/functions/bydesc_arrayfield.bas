# include "fbcu.bi"

namespace fbc_tests.functions.bydesc_arrayfield

const ARRAY_LB = 0
const ARRAY_UB = 9

type t1
	f1(ARRAY_LB to ARRAY_UB) as integer
	f2 as integer
end type

'':::::	
sub dotest ( array() as integer )
	dim as integer i
	
	for i = ARRAY_LB to ARRAY_UB
		CU_ASSERT( array(i) = i )
	next
	
end sub

sub fillarray ( array() as integer )
	dim as integer i
	
	for i = ARRAY_LB to ARRAY_UB
		array(i) = i
	next
	
end sub

sub test_loc_scl cdecl ()

	dim as t1 loc_scl
	
	fillarray( loc_scl.f1() )
	dotest( loc_scl.f1() )

end sub

sub test_loc_arr cdecl ()

	redim as t1 loc_arr(0 to 1)
	
	fillarray( loc_arr(1).f1() )
	dotest( loc_arr(1).f1() )

end sub

	dim shared as t1 glob_scl
	
sub test_glob_scl cdecl ()

	fillarray( glob_scl.f1() )
	dotest( glob_scl.f1() )

end sub

	dim shared as t1 glob_arr(0 to 1)
	
sub test_glob_arr cdecl ()

	fillarray( glob_arr(1).f1() )
	dotest( glob_arr(1).f1() )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.bydesc_arrayfield")
	fbcu.add_test("local scalar", @test_loc_scl)
	fbcu.add_test("local array", @test_loc_arr)
	fbcu.add_test("global scalar", @test_glob_scl)
	fbcu.add_test("global array", @test_glob_arr)

end sub

end namespace
