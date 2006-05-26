
/'

#error this shouldn't be parsed

'/


sub foo /' no alias '/ ( byval bar as zstring ptr /' const '/ = 0, _
						 byref baz as integer /' in-out '/ = 0 ) /' void '/

	assert( bar = 0 /' this comment wouldn't appear in assert '/ )

end sub

/'

	/'
		nested
	'/
	
#error this shouldn't be parsed
	
'/