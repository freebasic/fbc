' TEST_MODE : COMPILE_ONLY_OK

type UDT
	as integer i
	declare sub test( )
	declare constructor( )
	protected:
	declare constructor( byref as UDT )
end type

constructor UDT( )
end constructor

constructor UDT( byref rhs as UDT )
end constructor

sub passbyval( byval x as UDT )
end sub

sub UDT.test( )
	dim x1 as UDT
	dim x2 as UDT = x1

	dim as UDT ptr p
	p = new UDT( x1 )

	passbyval( x1 )
end sub
