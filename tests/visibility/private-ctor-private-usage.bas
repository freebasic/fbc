' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	private:
	declare constructor( )
end type

constructor T( )
end constructor

sub T.test( )
	static as T staticx

	dim as T x1
	dim as T x2 = T( )
	dim as T x3(0 to 1)

	dim as T ptr p
	p = new T( )
	p = new T[5]
end sub
