' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	protected:
	declare static sub foo( )
end type

static sub T.foo( )
end sub

sub T.test( )
	foo( )

	this.foo( )

	dim as T x
	x.foo( )

	T.foo( )

	dim as sub( ) p
	p = @foo
	p = @T.foo

	p = procptr( foo )
	p = procptr( T.foo )
end sub
