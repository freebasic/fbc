# include "fbcu.bi"



namespace fbc_tests.pointers.addrofnull

sub addrOfNullTest cdecl ()

	dim as integer ptr i1, i2, p
	dim as integer i

	i = 0
	i1 = @i
	i2 = i1
	
	CU_ASSERT_EQUAL( @p[*i1 + *i2], 0 )

end sub

private sub ctor () constructor

	fbcu.add_suite("fbc_tests.pointers.addrofnull")
	fbcu.add_test("addrOfNullTest", @addrOfNullTest)

end sub

end namespace
