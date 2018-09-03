function returnByrefInteger( ) byref as integer
	static as integer x
	function = x
end function

function returnInteger( ) as integer
	function = 123
end function

dim byval_i as function( )       as integer
dim byref_i as function( ) byref as integer

#print "2 warnings:"
byval_i = byref_i
#print "2 warnings:"
byref_i = byval_i

#print "no warnings:"
byval_i = @returnInteger
byref_i = @returnByrefInteger

#print "2 warnings:"
byval_i = @returnByrefInteger
#print "2 warnings:"
byref_i = @returnInteger
