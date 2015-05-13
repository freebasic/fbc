' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare sub dtor( )
end type

sub UDT.dtor( ) destructor
end sub
