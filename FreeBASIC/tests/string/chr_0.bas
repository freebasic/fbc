# include "fbcu.bi"




namespace fbc_tests.string_.chr_0

sub dynConstTest cdecl ()

	dim null_value as integer = 0

	dim dyn_str_0 as string = chr(null_value)
	dim const_str_0 as string = chr(0)

	dim dyn_str_0123 as string = chr(null_value, 1, 2, 3)
	dim const_str_0123 as string = chr(0, 1, 2, 3)

	dim dyn_str_3210 as string = chr(3, 2, 1, null_value)
	dim const_str_3210 as string = chr(3, 2, 1, 0)

	CU_ASSERT_EQUAL( dyn_str_0, const_str_0 )
	CU_ASSERT_EQUAL( dyn_str_0123, const_str_0123 )
	CU_ASSERT_EQUAL( dyn_str_3210, const_str_3210 )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.chr_0")
	fbcu.add_test("dynConstTest", @dynConstTest)

end sub

end namespace
