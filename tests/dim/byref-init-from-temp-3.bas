' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

'' TYPEINI
var byref x = type<UDT>(123)
