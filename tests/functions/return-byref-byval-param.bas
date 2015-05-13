' TEST_MODE : COMPILE_ONLY_FAIL

function f( byval i as integer ) byref as integer
	'' Reference to param on stack that will be popped
	function = i
end function
