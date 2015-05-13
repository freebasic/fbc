' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

function f( ) byref as integer
	dim x as UDT
	function = x.i
end function
