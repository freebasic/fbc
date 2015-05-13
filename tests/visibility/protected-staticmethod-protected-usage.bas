' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	protected:
	declare static sub foo( )
end type

static sub Parent.foo( )
end sub

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	foo( )
	this.foo( )
	base.foo( )

	dim as Parent x
	x.foo( )

	Parent.foo( )
	Child.foo( )

	dim as sub( ) p
	p = @foo
	p = @Parent.foo
	p = @Child.foo

	p = procptr( foo )
	p = procptr( Parent.foo )
	p = procptr( Child.foo )
end sub
