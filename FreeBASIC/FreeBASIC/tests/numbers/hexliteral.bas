# include "fbcu.bi"




namespace fbc_tests.numbers.hexliteral

sub test1 cdecl ()

	dim as ulongint lint

	lint = ((&hffffffff00000000ull shr 32) And &hffffffffll) 

	CU_ASSERT_EQUAL( lint, 4294967295ll )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.numbers.hexliteral")
	fbcu.add_test("test1", @test1)

end sub

end namespace
