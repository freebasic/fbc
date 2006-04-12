type vector
  as integer x, y, z
end type

function foo( ) as vector
	function = type( 7, 8, 9 )
end function

sub bar()

	dim as vector v = type( -1, -2, -3 )
	
	scope
		dim as vector a, b, c
		a = type( 1, 2, 3 )
	    b = type( 4, 5, 6 )
	    c = foo( )

		assert( a.x = 1 and a.y = 2 and a.z = 3 )
	    assert( b.x = 4 and b.y = 5 and b.z = 6 )
	    assert( c.x = 7 and c.y = 8 and c.z = 9 )
	end scope
	
	assert( v.x = -1 and v.y = -2 and v.z = -3 )

end sub

	bar()
