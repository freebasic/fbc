'':::::
function toupperz( byval s as string ) as string

	return ucase$( s )

end function

'':::::
function tolowerz( byval s as string ) as string

	return lcase$( s )

end function

'':::::
function concatz( byval s1 as string, byval s2 as string ) as string

	return s1 + s2

end function

'':::::
sub printstrings cdecl ( byval cnt as integer, ... )
	dim va as any ptr
	
	va = va_first( )
	
	for i = 1 to cnt
		print *va_arg( va, zstring ptr )
		va = va_next( va, string ptr )
	next i

end sub
	
	dim s as string
	dim z as zstring * 3+1
	
	s = "AbC"
	
	z = "aBc"
		
	printstrings 2, concatz( toupperz( s ), tolowerz( z ) ), concatz( tolowerz( z ), toupperz( s ) )
	
	sleep