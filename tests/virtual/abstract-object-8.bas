' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare abstract sub f1( )
end type

sub foo( byval x as A )
end sub
