' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	declare operator delete( byval as Parent ptr )
end type

operator Parent.delete( byval p as Parent ptr )
end operator

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as Parent ptr p
	delete p
end sub
