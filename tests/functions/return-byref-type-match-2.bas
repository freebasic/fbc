' TEST_MODE : COMPILE_ONLY_OK

function f() byref as const integer
	static i as integer = 0
	function = i
end function
