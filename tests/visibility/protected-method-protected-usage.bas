' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	protected:
	declare sub foo( )
end type

sub Parent.foo( )
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
end sub
