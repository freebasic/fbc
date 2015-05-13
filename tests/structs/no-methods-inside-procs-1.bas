' TEST_MODE : COMPILE_ONLY_FAIL

sub test( )
	type UDT
		dummy as integer

		'' Nested procedures aren't allowed,
		'' this method couldn't be implemented
		declare sub foo( )
	end type
end sub
