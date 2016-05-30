# include "fbcu.bi"




namespace fbc_tests.wstrings.len_

const TEST_LIT = "abcdef"
const TEST_LEN = 32
const TEST_SIZ = TEST_LEN * len( wstring )

sub test_1 cdecl ()

	dim s as wstring * TEST_LEN
	dim ps as wstring ptr
	
	s = TEST_LIT
	ps = @s
	
	CU_ASSERT( len( s ) = len( TEST_LIT ) )
	
	CU_ASSERT( sizeof( s ) = TEST_SIZ )
	
	CU_ASSERT( len( *ps ) = len( TEST_LIT ) )
	
	CU_ASSERT( len( ps ) = len( any ptr ) )
	
	CU_ASSERT( sizeof( ps ) = sizeof( any ptr ) )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstring.len")
	fbcu.add_test("test_1", @test_1)

end sub

end namespace
