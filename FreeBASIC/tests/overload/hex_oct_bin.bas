
	dim b as byte
	dim s as short
	dim i as integer
	dim l as longint
	dim p as any ptr

	b = -2 ^ 7
	s = -2 ^ 15
	i = -2 ^ 31
	l = -2LL ^ 63
	p = cptr( any ptr, i )
	
	assert( hex( b ) = "80" )
	assert( hex( s ) = "8000" )
	assert( hex( i ) = "80000000" )
	assert( hex( p ) = "80000000" )
	assert( hex( l ) = "8000000000000000" )

	assert( oct( b ) = "200" )
	assert( oct( s ) = "100000" )
	assert( oct( i ) = "20000000000" )
	assert( oct( p ) = "20000000000" )
	assert( oct( l ) = "1000000000000000000000" )

	assert( bin( b ) = "10000000" )
	assert( bin( s ) = "1000000000000000" )
	assert( bin( i ) = "10000000000000000000000000000000" )
	assert( bin( p ) = "10000000000000000000000000000000" )
	assert( bin( l ) = "1000000000000000000000000000000000000000000000000000000000000000" )

