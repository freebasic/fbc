' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
	declare sub test( )
	protected:
	declare operator @( ) as T ptr
end type

operator T.@( ) as T ptr
	operator = @this
end operator

sub T.test( )
	dim as T x
	dim as T ptr p = @x
end sub
