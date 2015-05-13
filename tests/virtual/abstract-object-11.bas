' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare abstract sub f( )
end type

sub foo( byref x as A )
end sub

foo( type() )
