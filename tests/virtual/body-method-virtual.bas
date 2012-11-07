' TEST_MODE : COMPILE_ONLY_FAIL

type UDT extends object
	dummy as integer
	declare sub f( )
end type

virtual sub UDT.f( )
end sub
