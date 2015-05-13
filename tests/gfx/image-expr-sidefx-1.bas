' TEST_MODE : COMPILE_ONLY_FAIL

type ArrayFieldUdt
	array(0 to 1023) as ubyte
end type

private function f1( byval p as ArrayFieldUdt ptr ) as ArrayFieldUdt ptr
	function = p
end function

dim x as ArrayFieldUdt
get (0, 0) - (31, 31), f1( @x )->array(0)
