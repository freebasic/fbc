' TEST_MODE : COMPILE_ONLY_FAIL

type UDT1
	dummy as integer
	declare constructor( )
end type

constructor UDT1( )
end constructor

sub test( )
	'' Not allowed because UDT2 would have an implicit default constructor,
	'' but procedures cannot be nested
	type UDT2 extends UDT1
	end type
end sub
