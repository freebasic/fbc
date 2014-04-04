' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array() as integer
	declare sub f( )
end type

sub UDT.f( )
	dim array(0 to 1) as integer
	redim array(0 to 1) as integer
end sub
