' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer
end type

declare operator *( byref x as UDT ) byref as integer

operator *( byref x as UDT ) as integer
	operator = x.dummy
end operator
