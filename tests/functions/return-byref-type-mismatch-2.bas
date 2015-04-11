' TEST_MODE : COMPILE_ONLY_FAIL

function f() byref as integer
	static i as const integer = 0
	function = i
end function
