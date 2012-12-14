' TEST_MODE : COMPILE_ONLY_FAIL

sub test( )
	type UDT
		dummy as integer
		declare static function foo( ) as integer
	end type
end sub
