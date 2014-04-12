' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array(0 to 1) as integer
	declare sub f( )
end type

sub UDT.f( )
	redim this.array(1 to 2)
end sub
