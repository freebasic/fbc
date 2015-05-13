' TEST_MODE : COMPILE_ONLY_FAIL

sub test( )
	'' Not allowed because UDT would have an implicit default constructor,
	'' thanks to the dynamic string field
	type UDT
		s as string
	end type
end sub
