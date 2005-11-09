option explicit

sub test1
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cubyte( src )
	
	assert( dst = &hFF )
end sub

sub test2
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cushort( src )
	
	assert( dst = &hFFFF )
end sub

sub test3
	dim as integer dst, src
	
	src = &hFFFFFFFF
	dst = cuint( src )
	
	assert( dst = &hFFFFFFFF )
end sub

	test1
	test2
	test3
