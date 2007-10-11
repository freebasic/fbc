# include "fbcu.bi"

namespace fbc_tests.functions.bydesc_array2

const ARRAY_LB1 = 1
const ARRAY_UB1 = 3
const ARRAY_LB2 = 2
const ARRAY_UB2 = 5

'':::::	
sub dotest ( array() as double )
	
	CU_ASSERT_EQUAL( lbound( array, 1 ), ARRAY_LB1 )
	CU_ASSERT_EQUAL( ubound( array, 1 ), ARRAY_UB1 )

	CU_ASSERT_EQUAL( lbound( array, 2 ), ARRAY_LB2 )
	CU_ASSERT_EQUAL( ubound( array, 2 ), ARRAY_UB2 )
	
end sub

sub dotest_pre ( array() as double )

	CU_ASSERT_EQUAL( lbound( array, 1 ), ARRAY_LB1 )
	CU_ASSERT_EQUAL( ubound( array, 1 ), ARRAY_UB1 )

	CU_ASSERT_EQUAL( lbound( array, 2 ), ARRAY_LB2 )
	CU_ASSERT_EQUAL( ubound( array, 2 ), ARRAY_UB2 )

	dotest( array() )	
end sub

sub test_loc cdecl ()

	dim as double loc_arr(ARRAY_LB1 to ARRAY_UB1, ARRAY_LB2 to ARRAY_UB2)
	
	dotest( loc_arr() )

end sub

	dim shared as double glob_arr(ARRAY_LB1 to ARRAY_UB1, ARRAY_LB2 to ARRAY_UB2)
	
sub test_glob cdecl ()

	dotest( glob_arr() )

end sub

sub test_param cdecl ()

	dotest_pre( glob_arr() )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.functions.bydesc_array2")
	fbcu.add_test("local array", @test_loc)
	fbcu.add_test("global array", @test_glob)
	fbcu.add_test("param array", @test_param)

end sub

end namespace