# include "fbcunit.bi"

SUITE( fbc_tests.const_.const_to_const )
	
	sub foo( byref bas as const string )
	end sub
	
	TEST( const_arg )
		dim as const string bar = "hi"
		foo( bar )
	END_TEST
	
END_SUITE
