''
'' FUNCTIONs can return their result BYREF, similar to BYREF parameters,
'' which can be used to avoid unnecessary copies, or to allow modification
'' of the variable/object returned from a function.
''

dim shared dat(0 to ...) as zstring * 512 = _
{ _
	( "stand still"        ), _
	( "jump the mountains" ), _
	( "walk the streets"   ), _
	( "swim the oceans"    ), _
	( "fly like the wind"  ) _
}

function accessRandomElement( ) byref as zstring
	function = dat( rnd( ) * ubound( dat ) )
end function

	randomize( timer( ) )

	for i as integer = 1 to 10
		print accessRandomElement( )
		accessRandomElement( ) += " +1"
	next
