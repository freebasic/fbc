# include "fbcu.bi"



namespace fbc_tests.pointers.multi_deref

const TEST_VAL = &hDeadBeef
	
sub test cdecl ()

	dim i as integer, v as integer
	dim p as integer ptr
	dim pp as integer ptr ptr
	
	pp = @p
	p = @v
	v = TEST_VAL
	
	i = 0
	
	CU_ASSERT_EQUAL( pp[i][i], TEST_VAL )
	CU_ASSERT_EQUAL( **pp, TEST_VAL )
	CU_ASSERT_EQUAL( **(pp+i), TEST_VAL )
	CU_ASSERT_EQUAL( *(pp+i)[i], TEST_VAL )
	
end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.multi_deref")
	fbcu.add_test("test", @test)

end sub

end namespace
	
