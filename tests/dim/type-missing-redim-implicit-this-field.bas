' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	x as integer
	declare sub f( )
end type

sub UDT.f( )
	redim x(1 to 2)
end sub
