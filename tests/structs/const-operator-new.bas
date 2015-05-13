' TEST_MODE : COMPILE_ONLY_FAIL

type UDT extends object
	i as integer
	declare const operator new(i as integer) as UDT ptr
end type
