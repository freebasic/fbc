
type udt
	a as integer
	b as short
end type

type udt2
	dummy as integer
	udt	as udt
end type

sub test1	
	dim as udt t1, t2
	
	t1.a = 1
	t1.b = 2
	t2.a = 3
	t2.b = 4
	
	swap t1, t2
	
	assert( t1.b = 4 ) 
	assert( t1.a = 3 ) 
	assert( t2.b = 2 ) 
	assert( t2.a = 1 ) 
	
end sub

sub test2
	static as udt t1 = (1, 2), t2 = (3, 4)
	
	swap t1, t2
	
	assert( t1.b = 4 ) 
	assert( t1.a = 3 ) 
	assert( t2.b = 2 ) 
	assert( t2.a = 1 ) 
	
end sub

sub test3
	dim as udt t1 = (1, 2), t2 = (3, 4)
	
	swap t1, t2
	
	assert( t1.b = 4 ) 
	assert( t1.a = 3 ) 
	assert( t2.b = 2 ) 
	assert( t2.a = 1 ) 
	
end sub

sub test4
	static as udt t1 = (1, 2), t2 = (3, 4)
	dim as udt ptr p1 = @t1, p2 = @t2
	
	swap *p1, *p2
	
	assert( t1.b = 4 ) 
	assert( t1.a = 3 ) 
	assert( t2.b = 2 ) 
	assert( t2.a = 1 ) 
	
end sub

sub test5
	static as udt2 t1 = (0, (1, 2)), t2 = (0, (3, 4))
	dim as udt2 ptr p1 = @t1, p2 = @t2
	
	swap p1->udt, p2->udt
	
	assert( t1.udt.b = 4 ) 
	assert( t1.udt.a = 3 ) 
	assert( t2.udt.b = 2 ) 
	assert( t2.udt.a = 1 ) 
	
end sub

	test1
	test2
	test3
	test4
	test5