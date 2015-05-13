' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array(any) as integer
end type

dim x as UDT
print x.array(0)
print x.array(0, 0)
