' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	protected:
	declare operator cast( ) as integer
end type

operator T.cast( ) as integer
	operator = i
end operator

sub T.test( )
	dim as T x
	dim as integer i
	i = x
end sub
