' TEST_MODE : COMPILE_ONLY_FAIL

type UDT1
	i as integer
end type

type UDT2
	i as integer
end type

dim as integer c
dim l as UDT1 ptr, r as UDT2 ptr

print iif( c, l, r )
