'':::::
function toupperz( byval s as string ) as string

	return ucase$( s )

end function

'':::::
function tolowerz( byval s as string ) as string

	return lcase$( s )

end function

'':::::
function touppers( s as string ) as string

	return ucase$( s )

end function

'':::::
function tolowers( s as string ) as string

	return lcase$( s )

end function

'':::::
function concatz( byval s1 as string, byval s2 as string ) as string

	return s1 + s2

end function

	dim s as string
	dim z as zstring * 3+1
	dim r as string
	
	s = "AbC"
	
	z = "aBc"
		
	r = toupperz( tolowerz( toupperz( tolowerz( s ) ) ) )
	if( r <> "ABC" ) then
		print "should be upper!"
	end if
	print r
	
	r = tolowers( touppers( tolowers( touppers( s ) ) ) )
	if( r <> "abc" ) then
		print "should be lower!"
	end if
	print r
	
	r = concatz( toupperz( s ), tolowers( z ) )
	if( r <> "ABCabc" ) then
		print "wrong result!"
	end if
	print r
	
	sleep