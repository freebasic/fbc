' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	p as any ptr
	declare operator cast( ) as ubyte ptr
	declare operator cast( ) as ulong ptr
end type

operator UDT.cast( ) as ubyte ptr
	operator = p
end operator

operator UDT.cast( ) as ulong ptr
	operator = 0
end operator

dim x as UDT
line x, (0, 0) - (31, 31), rgb(0,0,0), bf
