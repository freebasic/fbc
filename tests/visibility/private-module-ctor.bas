' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer

private:
	declare static sub ctor( )
end type

sub UDT.ctor( ) constructor
end sub
