' TEST_MODE : COMPILE_ONLY_FAIL

type UDT1
	i as integer
end type

type UDT2
	i as integer
end type

dim as integer c
dim x1 as UDT1, x2 as UDT2

x1 = iif( c, x1, x2 )
