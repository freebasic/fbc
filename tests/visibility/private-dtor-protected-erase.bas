' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	declare destructor cdecl( )
end type

destructor Parent cdecl( )
end destructor

type Child extends Parent
	declare sub test( x() as Parent )
end type

sub Child.test( x() as Parent )
	erase x
end sub
