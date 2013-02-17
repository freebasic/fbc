' TEST_MODE : COMPILE_ONLY_FAIL

type UDT extends object
	i as integer
end type

dim x as UDT
dim px as UDT ptr = @x
*cptr( const UDT ptr, px ) = 123
