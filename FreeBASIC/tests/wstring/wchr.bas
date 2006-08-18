

const TEST_1 = wchr( 65, 66, 67 )
const TEST_2 = wchr( 256, 257, 258 )

declare sub run_test( byval s1 as wstring ptr, byval s2 as wstring ptr )	

	dim s as wstring * 32
	dim ps as wstring ptr
	
	s = TEST_1
	run_test( s, TEST_1 )

	s = TEST_2
	run_test( s, TEST_2 )
	
	
sub run_test( byval s1 as wstring ptr, byval s2 as wstring ptr )	
	
	assert( len( *s1 ) = len( *s2 ) )
	
	assert( *s1 = *s2 )
	
end sub
