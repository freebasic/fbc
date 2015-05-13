' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	p as any ptr
	declare operator cast( ) as string
end type

operator UDT.cast( ) as string
	operator = ""
end operator

dim x as UDT
line x, (0, 0) - (31, 31), rgb(0,0,0), bf
