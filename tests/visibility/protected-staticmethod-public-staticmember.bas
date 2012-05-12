' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare static sub foo( )
end type

static sub T.foo( )
end sub

T.foo( )
