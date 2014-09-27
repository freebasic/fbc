' TEST_MODE : COMPILE_ONLY_FAIL

function f(byval x as integer) byref as integer
	static i as integer
	function = i
end function

(f(0)) &= 1
