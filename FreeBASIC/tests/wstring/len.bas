

const TEST_LIT = "abcdef"
const TEST_LEN = 32
const TEST_SIZ = TEST_LEN * len( wstring )

	dim s as wstring * TEST_LEN
	dim ps as wstring ptr
	
	s = TEST_LIT
	ps = @s
	
	assert( len( s ) = len( TEST_LIT ) )
	
	assert( sizeof( s ) = TEST_SIZ )
	
	assert( len( *ps ) = len( TEST_LIT ) )
	
	assert( len( ps ) = len( any ptr ) )
	
	assert( sizeof( ps ) = sizeof( any ptr ) )
		