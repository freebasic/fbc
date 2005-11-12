'':::::
function toupperz( byval s as string ) as string

	return ucase( s )

end function

'':::::
function tolowerz( byval s as string ) as string

	return lcase( s )

end function

'':::::
function touppers( byref s as string ) as string

	return ucase( s )

end function

'':::::
function tolowers( byref s as string ) as string

	return lcase( s )

end function

'':::::
function concatz( byval s1 as string, byval s2 as string ) as string

	return s1 + s2

end function

	dim s as string
	dim z as zstring * 3+1
	dim r as string
	
	s = "AbC"
	
	z = "dEf"
		
	r = toupperz( tolowerz( toupperz( tolowerz( s ) ) ) )
	assert( r = "ABC" )
	
	r = tolowers( touppers( tolowers( touppers( s ) ) ) )
	assert( r = "abc" )
	
	r = concatz( toupperz( s ), tolowers( z ) )
	assert( r = "ABCdef" )
	