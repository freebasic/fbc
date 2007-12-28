# include "fbcu.bi"




namespace fbc_tests.wstrings.concat_conv

const TESTVALUE_1 = "abcd"
const TESTVALUE_2 = "EFGH"

sub test_1 cdecl ()

	dim as wstring * 32 w = TESTVALUE_1
	dim as zstring * 32 z = TESTVALUE_2
	dim as wstring * 256 res
	
	res = w + z
	
	CU_ASSERT( res = wstr(TESTVALUE_1) + wstr(TESTVALUE_2) )
	
	res = z + w
	
	CU_ASSERT( res = wstr(TESTVALUE_2) + wstr(TESTVALUE_1) )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstrings.concat_conv")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
