type t
	a as short
	b as integer
	c(0 to 1) as single
	d as double
end type


sub test1
	dim as t udt = (1, 2, {3, 4}, 5 ) 
	
	assert( udt.a = 1 )
	assert( udt.b = 2 )
	assert( udt.c(0) = 3 )
	assert( udt.c(1) = 4 )
	assert( udt.d = 5 )
end sub

sub test2
	static as t udt = (1, 2, {3, 4}, 5 ) 
	
	assert( udt.a = 1 )
	assert( udt.b = 2 )
	assert( udt.c(0) = 3 )
	assert( udt.c(1) = 4 )
	assert( udt.d = 5 )
end sub

sub test3
	dim as t udt
	
	udt = type( -1, -2, {-3, -4}, -5 )

	assert( udt.a = -1 )
	assert( udt.b = -2 )
	assert( udt.c(0) = -3 )
	assert( udt.c(1) = -4 )
	assert( udt.d = -5 )	
end sub

sub test4 static
	dim as t udt
	
	udt = type( -1, -2, {-3, -4}, -5 )

	assert( udt.a = -1 )
	assert( udt.b = -2 )
	assert( udt.c(0) = -3 )
	assert( udt.c(1) = -4 )
	assert( udt.d = -5 )	
end sub

	test1
	test2
	test3
	test4