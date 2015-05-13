' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

dim p as UDT ptr
line *p, (0, 0) - (31, 31), rgb(0,0,0)
