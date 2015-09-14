' TEST_MODE : COMPILE_ONLY_FAIL

'' Big UDT that probably won't be returned in registers,
'' i.e. will be returned through a temp var on stack
type UDT
	as long a, b, c, d, e, f
end type

function f() as UDT
	function = type<UDT>(1, 2, 3, 4, 5, 6)
end function

var byref x = f()
