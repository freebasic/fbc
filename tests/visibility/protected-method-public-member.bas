' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare sub foo( )
end type

sub T.foo( )
end sub

dim as T x
x.foo( )
