' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	protected:
	declare sub foo( )
end type

sub T.foo( )
end sub

sub T.test( )
	foo( )

	this.foo( )

	dim as T x
	x.foo( )
end sub
