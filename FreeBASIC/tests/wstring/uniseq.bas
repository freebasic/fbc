option explicit

const TEST_1 = "A\u0022\u0023B\u0024\u0025C\u0026"
const TEST_2 = "\t\u0022\u0023\r\u0024\u0025C\u0026\n"

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
