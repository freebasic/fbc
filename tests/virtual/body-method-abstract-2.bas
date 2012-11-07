' TEST_MODE : COMPILE_ONLY_FAIL

type UDT extends object
	dummy as integer
	declare abstract sub f( )
end type

sub UDT.f( )
end sub
