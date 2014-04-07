' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array() as integer
end type

dim x as UDT
redim x.array(0 to 0)
redim x.array(0 to 0, 0 to 0)
