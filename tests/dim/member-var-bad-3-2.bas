' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer
	declare constructor( )
end type

constructor UDT( )
end constructor

'' UDT.i was not declared
dim UDT.i as integer
