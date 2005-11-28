	
	dim as integer ptr p1, p2, tb
	
	tb = allocate( 2 * len( integer ) )

	p1 = @tb[0]
	p2 = @tb[1]
	
	assert( p2 - p1 = 1 )
	 
	assert( p1 + 1 = @tb[1] )

	p1 += 1
	assert( p1 = @tb[1] )

	assert( p2 - 1 = @tb[0] )

	p2 -= 1
	assert( p2 = @tb[0] )
