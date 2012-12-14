' TEST_MODE : COMPILE_ONLY_FAIL

type UDT1
	dummy as integer
	declare destructor( )
end type

destructor UDT1( )
end destructor

sub test( )
	'' Not allowed because UDT2 would have an implicit destructor,
	'' but procedures cannot be nested
	type UDT2 extends UDT1
	end type
end sub
