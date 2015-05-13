' TEST_MODE : COMPILE_ONLY_FAIL

type UDT extends object
	dummy as integer
	declare constructor( )
end type

virtual constructor UDT( )
end constructor
