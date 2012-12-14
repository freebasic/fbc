' TEST_MODE : COMPILE_ONLY_FAIL

sub test( )
	type UDT
		dummy as integer

		'' The same goes for static member procedures
		declare static sub foo( )
	end type
end sub
