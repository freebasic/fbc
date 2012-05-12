' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	protected:
	declare operator @( ) as Parent ptr
end type

operator Parent.@( ) as Parent ptr
	operator = @this
end operator

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as Parent x
	dim as Parent ptr p = @x
end sub
