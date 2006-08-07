sub foo overload ()
end sub
 
function foo overload (byval v as integer) as integer
	function = v
end function

	assert( foo(1234) = 1234 )
