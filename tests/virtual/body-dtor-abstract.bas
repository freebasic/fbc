' TEST_MODE : COMPILE_ONLY_FAIL

type UDT extends object
	dummy as integer
	declare destructor( )
end type

abstract destructor UDT
end destructor
