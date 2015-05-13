' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare constructor( )
	declare constructor( as integer )
end type

constructor UDT( )
end constructor

constructor UDT( i as integer )
end constructor

'' Same: Global initializer referencing non-shared static
static as integer static_i
dim shared as UDT global_x = UDT( static_i )
