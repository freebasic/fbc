' TEST_MODE : COMPILE_ONLY_FAIL

type UDT extends object
	i as integer
	declare virtual operator delete(p as UDT ptr)
end type
