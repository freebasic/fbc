' TEST_MODE : COMPILE_ONLY_FAIL

function f() byref as integer
	static i as double
	function = i
end function
