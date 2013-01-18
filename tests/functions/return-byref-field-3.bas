' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	a(0 to 1) as integer
end type

function f( ) byref as integer
	dim x as UDT
	dim i as integer
	function = x.a(i)
end function
