' TEST_MODE : COMPILE_ONLY_FAIL

type ArrayFieldUdt
	array(0 to 1023) as ubyte
end type

private function f2( byref x as ArrayFieldUdt ) as ArrayFieldUdt
	function = x
end function

dim x as ArrayFieldUdt
get (0, 0) - (31, 31), f2( x ).array(0)
