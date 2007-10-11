# include "fbcu.bi"



namespace fbc_tests.pointers.addr_deref

const TEST_VAL = 12345678

sub derefAddressOfTest cdecl ()

	dim as integer a, b
	dim as integer ptr p

	b = TEST_VAL

	a = *@b 
	CU_ASSERT( a = TEST_VAL )
	 
	p = @a
	CU_ASSERT( *p = TEST_VAL )

	p = @(a)
	CU_ASSERT( *p = TEST_VAL )

	p = @*p
	CU_ASSERT( *p = TEST_VAL )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.addr_deref")
	fbcu.add_test("derefAddressOfTest", @derefAddressOfTest)

end sub

end namespace
