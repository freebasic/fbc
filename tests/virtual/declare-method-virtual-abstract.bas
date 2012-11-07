' TEST_MODE : COMPILE_ONLY_FAIL

type UDT extends object
	dummy as integer
	declare virtual abstract sub f( )
end type
