' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array(any) as integer
end type

sub f1( )
	dim x as UDT
	print x.array(0)
end sub

sub f2( )
	dim x as UDT
	print x.array(0, 0)
end sub
