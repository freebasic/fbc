
const TEST_1 = "abcDEFghi"
const TEST_2 = "0123456789"


'':::::
sub f1( byval s1 as string, byref s2 as string )

	assert( s1 = TEST_1 )
	assert( s2 = TEST_2 )

end sub

'':::::
sub f2( byref s1 as string, byval s2 as string )

	assert( s1 = TEST_1 )
	assert( s2 = TEST_2 )
	
	f1( s1, s2 )

end sub

'':::::
sub f3( byval s1 as string, byref s2 as string )

	assert( s1 = TEST_1 )
	assert( s2 = TEST_2 )

	f2( s1, s2 )

end sub

'':::::
sub f4( byval s1 as zstring ptr, byval s2 as string )

	assert( *s1 = TEST_1 )
	assert( s2 = TEST_2 )
	
	f3( *s1, s2 )

end sub


	dim s as string
	dim z as zstring * 15+1
	
	s = TEST_1
	z = TEST_2
	
	f3 s, z
	
	f2 s, z
	
	f4 strptr( s ), z
	

