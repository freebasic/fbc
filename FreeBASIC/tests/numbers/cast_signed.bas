

sub test1
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cbyte( src )
	
	assert( dst = -1 )
end sub

sub test2
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cshort( src )
	
	assert( dst = -1 )
end sub

sub test3
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cint( src )
	
	assert( dst = -1 )
end sub

	test1
	test2
	test3
