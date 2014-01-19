' TEST_MODE : COMPILE_ONLY_FAIL

type ArrayFieldUdt
	array(0 to 1023) as ubyte
end type

private function f3( byref x as ArrayFieldUdt ) byref as ArrayFieldUdt
	function = x
end function

dim x as ArrayFieldUdt
get (0, 0) - (31, 31), f3( x ).array(0)
