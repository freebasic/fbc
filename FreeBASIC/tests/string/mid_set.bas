# include once "fbcu.bi"




namespace fbc_tests.string_.mid_set

sub midSetTest cdecl ()

	dim h as string = "123"
	dim test as string * 3
	dim i as integer

	for i = 1 to 260
	  mid(test,1) = h
	  CU_ASSERT_NOT_EQUAL( 0, len(str(i)) )
	next

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.mid_set")
	fbcu.add_test("midSetTest", @midSetTest)

end sub

end namespace
