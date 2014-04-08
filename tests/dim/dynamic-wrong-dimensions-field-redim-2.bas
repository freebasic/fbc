' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array(any) as integer
end type

dim shared x as UDT

sub f1( )
	redim x.array(0 to 0)
end sub

sub f2( )
	redim x.array(0 to 0, 0 to 0)
end sub
