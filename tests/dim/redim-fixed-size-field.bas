' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array(0 to 0) as any ptr
	declare sub f()
end type

sub UDT.f()
	redim preserve array(0 to 1)
end sub
