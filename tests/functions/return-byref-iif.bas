' TEST_MODE : COMPILE_ONLY_FAIL

dim shared as integer a, b, c

function f( ) byref as integer
	function = iif( a, b, c )
end function
