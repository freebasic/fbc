' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	declare operator +=( byref as Parent )
end type

operator Parent.+=( byref other as Parent )
end operator

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim as Parent x
	x += x
end sub
