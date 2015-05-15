' TEST_MODE : COMPILE_ONLY_OK

type UDT
	i as integer
end type

dim x as UDT
*cptr(UDT ptr, 0) = x
