' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array(any) as integer
	declare sub f( )
end type

sub UDT.f( )
	dim array(0 to 1) as integer

	'' Can't REDIM fixed-size array
	'' (this lookup should resolve to the local fixed-size array, not the
	'' dynamic array field via implicit THIS)
	redim array(0 to 1) as integer
end sub
