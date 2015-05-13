' TEST_MODE : COMPILE_ONLY_FAIL

dim shared as integer a

function f( ) byref as integer
	function = @a
end function
