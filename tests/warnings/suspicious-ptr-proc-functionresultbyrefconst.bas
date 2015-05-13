'' CONST/BYREF bits in integer function result

function returnByrefInteger( ) byref as integer
	static as integer x
	function = x
end function

function returnInteger( ) as integer
	function = 123
end function

dim p1 as function( ) as integer
dim p2 as function( ) as const integer
dim p3 as function( ) byref as integer
dim p4 as function( ) byref as const integer

#print "3 warnings:"
p1 = p2
p1 = p3
p1 = p4

#print "3 warnings:"
p2 = p1
p2 = p3
p2 = p4

#print "3 warnings:"
p3 = p1
p3 = p2
p3 = p4

#print "3 warnings:"
p4 = p1
p4 = p2
p4 = p3

#print "no warnings:"
p1 = @returnInteger
p3 = @returnByrefInteger

#print "2 warnings:"
p1 = @returnByrefInteger
p3 = @returnInteger
