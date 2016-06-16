# include "fbcu.bi"




namespace fbc_tests.wstrings.utf8

#define hello "Καλημέρα "
#define world "κόσμε!"
#define helloworld hello + world

sub test_1 cdecl ()

	dim as wstring * 32 hw1 = "Καλημέρα κόσμε!"
	dim as wstring * 32 hw2 = helloworld

	CU_ASSERT( hw1 = hw2 )

	CU_ASSERT( hw1 = helloworld )

	CU_ASSERT( helloworld = hw2 )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstring.utf8")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
