' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	protected:
	declare operator cast( ) as integer
end type

operator Parent.cast( ) as integer
	operator = i
end operator

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as Parent x
	dim as integer i
	i = x
end sub
