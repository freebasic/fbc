' TEST_MODE : COMPILE_ONLY_FAIL

type UDT extends object
	i as integer
end type

dim px as UDT ptr
cptr( UDT const ptr, px ) = 0
