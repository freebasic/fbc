' TEST_MODE : COMPILE_ONLY_FAIL

'' UDT that fits in registers
type UDT
	i as integer
end type

function f1( ) as UDT
	function = type( 123 )
end function

function f2( ) byref as UDT
	'' Cannot take addrof UDT result in regs
	function = f1( )
end function
