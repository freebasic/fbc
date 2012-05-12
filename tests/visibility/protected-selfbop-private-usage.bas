' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	protected:
	declare operator +=( byref as T )
end type

operator T.+=( byref other as T )
end operator

sub T.test( )
	dim as T x
	x += x
end sub
