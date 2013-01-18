' TEST_MODE : COMPILE_ONLY_FAIL

dim shared as integer a, b

function f( ) byref as integer
	function = a + b
end function
