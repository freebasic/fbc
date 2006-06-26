option explicit

	dim shared as string v
	dim shared as string * 10 f
	dim shared as zstring * 10 z
	dim shared as zstring ptr pz
	dim shared as wstring * 10 w
	dim shared as wstring ptr pw

	v = ""
	f = ""
	z = ""
	pz = 0
	w = wstr("")
	pw = 0

sub test1
	assert( v = f )
	assert( v = z )
	assert( v = *pz )
	assert( v = w )
	assert( v = *pw )
end sub

sub test2
	assert( f = v )
	assert( f = z )
	assert( f = *pz )
	assert( f = w )
	assert( f = *pw )
end sub

sub test3
	assert( z = v )
	assert( z = f )
	assert( z = *pz )
	assert( z = w )
	assert( z = *pw )
end sub

sub test4
	assert( *pz = v )
	assert( *pz = f )
	assert( *pz = z )
	assert( *pz = w )
	assert( *pz = *pw )
end sub

sub test5
	assert( w = v )
	assert( w = f )
	assert( w = z )
	assert( w = *pz )
	assert( w = *pw )
end sub

sub test6
	assert( *pw = v )
	assert( *pw = f )
	assert( *pw = z )
	assert( *pw = *pz )
	assert( *pw = w )
end sub

	test1
	test2
	test3
	test4
	test5
	test6