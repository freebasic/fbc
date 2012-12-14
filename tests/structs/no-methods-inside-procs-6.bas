' TEST_MODE : COMPILE_ONLY_FAIL

sub test( )
	type UDT
		dummy as integer
		declare destructor( )
	end type
end sub
