' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	a(0 to 1) as integer
end type

function f( ) byref as integer
	dim x as UDT
	function = x.a(1)
end function
