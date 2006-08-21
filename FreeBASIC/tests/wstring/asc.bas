# include "fbcu.bi"




namespace fbc_tests.wstrings.asc_

const TEST_A = asc( wstr( "abc" ), 1 )
const TEST_B = asc( wstr( "abc" ), 2 )
const TEST_C = asc( wstr( "abc" ), 3 )
const TEST_D = asc( wstr( "abc" ), 4 )

sub test_1 cdecl ()

	CU_ASSERT( TEST_A = asc( wstr( "a" ) ) )
	
	CU_ASSERT( TEST_B = asc( wstr( "b" ) ) )
	
	CU_ASSERT( TEST_C = asc( wstr( "c" ) ) )
	
	CU_ASSERT( TEST_D = 0 )
	
end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstrings.asc_")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
