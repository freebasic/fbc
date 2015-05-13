' TEST_MODE : COMPILE_ONLY_FAIL

sub test( )
	type UDT
		dummy as integer
		declare operator let( as UDT )
	end type
end sub
