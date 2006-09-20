# include "fbcu.bi"

namespace fbc_tests.string_.array_len

	dim shared as string foo()  

sub test cdecl ()

	CU_ASSERT_EQUAL( len(foo), len(string ) )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string.array_len")
	fbcu.add_test("test", @test)

end sub

end namespace
