' TEST_MODE : COMPILE_ONLY_OK

type Parent
	as integer i
	declare constructor( )
	protected:
	declare constructor( byref as Parent )
end type

constructor Parent( )
end constructor

constructor Parent( byref rhs as Parent )
end constructor

sub passbyval( byval x as Parent )
end sub

type Child extends Parent
	declare sub test( )
end type

sub Child.test( )
	dim x1 as Parent
	dim x2 as Parent = x1

	dim as Parent ptr p
	p = new Parent( x1 )

	passbyval( x1 )
end sub
