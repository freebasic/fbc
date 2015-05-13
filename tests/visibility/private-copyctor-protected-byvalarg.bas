' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	declare constructor( )
	private:
	declare constructor( byref as Parent )
end type

constructor Parent( )
end constructor

constructor Parent( byref rhs as Parent )
end constructor

type Child extends Parent
	declare sub test( )
end type

sub passbyval( byval x as Parent )
end sub

sub Child.test( )
	dim x1 as Parent
	passbyval( x1 )
end sub
