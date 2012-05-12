' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	protected:
	declare destructor( )
end type

destructor T( )
end destructor

sub T.test( )
	static as T staticx

	dim as T x1
	dim as T x2(0 to 1)

	dim as T ptr p
	delete p
	delete[] p
end sub
