' TEST_MODE : COMPILE_ONLY_FAIL

function f() byref as zstring * 10
	return "hi"
end function
