' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare const destructor()
end type

const destructor UDT()
end destructor
