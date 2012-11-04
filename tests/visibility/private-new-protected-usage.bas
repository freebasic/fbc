' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	declare operator new( byval as uinteger ) as Parent ptr
end type

operator Parent.new( byval size as uinteger ) as Parent ptr
	operator = 0
end operator

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as Parent ptr p = new Parent
end sub
