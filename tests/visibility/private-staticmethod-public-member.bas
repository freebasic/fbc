' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	private:
	declare static sub foo( )
end type

static sub T.foo( )
end sub

dim as T x
x.foo( )
