' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( x() as T )
	protected:
	declare destructor cdecl( )
end type

destructor T cdecl( )
end destructor

sub T.test( x() as T )
	erase x

	static as T staticx

	dim as T x1
	dim as T x2(0 to 1)

	dim as T ptr p
	delete p
	delete[] p
end sub
