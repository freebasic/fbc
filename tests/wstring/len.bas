#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.len_ )

	const TEST_LIT = "abcdef"
	const TEST_LEN = 32
	const TEST_SIZ = TEST_LEN * len( wstring )

	TEST( default )

		dim s as wstring * TEST_LEN
		dim ps as wstring ptr
		
		s = TEST_LIT
		ps = @s
		
		CU_ASSERT( len( s ) = len( TEST_LIT ) )
		
		CU_ASSERT( sizeof( s ) = TEST_SIZ )
		
		CU_ASSERT( len( *ps ) = len( TEST_LIT ) )
		
		CU_ASSERT( len( ps ) = len( any ptr ) )
		
		CU_ASSERT( sizeof( ps ) = sizeof( any ptr ) )

	END_TEST

END_SUITE
