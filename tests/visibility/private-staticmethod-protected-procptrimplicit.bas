' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	declare static sub foo( )
end type

static sub Parent.foo( )
end sub

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as sub( ) p
	p = procptr( foo )
end sub
