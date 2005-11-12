
'':::::
sub nocopyback( byval s as string )

	s = ucase( s )
	
end sub

'':::::
sub copyback( byref s as string )

	s = ucase( s )
	
end sub

	dim s as string
	dim z as zstring * 3+1
	dim f as string * 3
	
	s = "var"
	nocopyback( s )
	assert( s = "VAR" )

	s = "var"
	copyback( s )
	assert( s = "VAR" )
	
	z = "zer"
	copyback( z )
	assert( z = "zer" )
	
	z = "zer"
	nocopyback( z )
	assert( z = "ZER" )

	f = "fix"
	nocopyback( f )
	assert( f = "FIX" )

	f = "fix"
	copyback( f )
	assert( f = "FIX" )
	
