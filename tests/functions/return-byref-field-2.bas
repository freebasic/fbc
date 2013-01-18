' TEST_MODE : COMPILE_ONLY_FAIL

type UDT1
	i as integer
end type

type UDT2
	x as UDT1
end type

function f( ) byref as integer
	dim x as UDT2
	function = x.x.i
end function
