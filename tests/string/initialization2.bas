# include "fbcu.bi"

namespace fbc_tests.string_.init2

sub test_1 cdecl ()

	dim as string a = "abc"
	dim as string b = a
	dim as string c = a + b
	
	CU_ASSERT_EQUAL( b, "abc" )
	CU_ASSERT_EQUAL( c, "abcabc" )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string.initialization2")
	fbcu.add_test("#1", @test_1)

end sub

end namespace
