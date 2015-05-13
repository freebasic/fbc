' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

dim x as UDT
line x, (0, 0) - (31, 31), rgb(0,0,0)
