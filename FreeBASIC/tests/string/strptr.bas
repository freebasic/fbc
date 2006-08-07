
	dim as string ptr foo
	dim as string bar = "1234"
	dim as zstring ptr p

	foo = @bar
	p = strptr( *foo )
	assert( *p = "1234" )
	
	
	