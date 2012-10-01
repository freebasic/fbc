' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare destructor cdecl( )
end type

destructor T cdecl( )
end destructor

sub test( x() as T )
	erase x
end sub
