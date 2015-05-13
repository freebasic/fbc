' TEST_MODE : COMPILE_ONLY_FAIL

sub test( )
	'' Not allowed because UDT would have an implicit default constructor,
	'' since OBJECT has one too
	type UDT extends object
	end type
end sub
