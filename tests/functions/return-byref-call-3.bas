' TEST_MODE : COMPILE_ONLY_FAIL

'' UDT that must be returned on stack
type UDT
	a(0 to 63) as integer
end type

function f1( ) as UDT
	function = type( { 123 } )
end function

function f2( ) byref as UDT
	'' Cannot take addrof local UDT result temp var
	function = f1( )
end function
