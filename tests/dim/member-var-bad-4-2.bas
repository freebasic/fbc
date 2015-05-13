' TEST_MODE : COMPILE_ONLY_FAIL

'' Class UDT
type UDT
	i as integer
	declare constructor( )
end type

constructor UDT( )
end constructor

'' UDT.i is a field, not a member var
dim UDT.i as integer
