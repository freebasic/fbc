' TEST_MODE : COMPILE_ONLY_FAIL

function f() as integer
	function = 0
end function

var byref i = f()
