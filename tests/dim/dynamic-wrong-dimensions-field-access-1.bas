' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array() as integer
end type

dim x as UDT
print x.array(0)
print x.array(0, 0)
