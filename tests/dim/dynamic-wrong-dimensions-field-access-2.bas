' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array(any) as integer
end type

dim shared x as UDT

sub f1( )
	print x.array(0)
end sub

sub f2( )
	print x.array(0, 0)
end sub
