' TEST_MODE : COMPILE_ONLY_FAIL

type UDT1
	i as integer
end type

type UDT2
	i as integer
end type

dim as integer c
dim p1 as UDT1 ptr
dim x1 as UDT1

x1 = iif( c, p1, x1 )
