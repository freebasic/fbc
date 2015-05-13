' TEST_MODE : COMPILE_ONLY_OK

type T
	declare sub test( )
	protected:
	i as integer
end type

sub T.test( )
	dim as integer n
	n = i
	n = this.i

	dim as T x
	n = x.i

	let( n ) = x
end sub
