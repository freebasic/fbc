' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	private:
	declare operator new( byval as uinteger ) as T ptr
end type

operator T.new( byval size as uinteger ) as T ptr
	operator = 0
end operator

sub T.test( )
	dim as T ptr p = new T
end sub
