' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	protected:
	static x as integer
end type

dim T.x as integer

sub T.test( )
	x = 123
	T.x = 123
	this.x = 123
	dim as integer y1 = x
	dim as integer y2 = T.x
	dim as integer y3 = this.x
end sub
