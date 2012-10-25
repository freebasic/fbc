' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	private:
	declare operator delete( byval as T ptr )
end type

operator T.delete( byval p as T ptr )
end operator

sub T.test( )
	dim as T ptr p
	delete p
end sub
