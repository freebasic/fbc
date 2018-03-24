# include "fbcunit.bi"

SUITE( fbc_tests.const_.nonconst_to_const )
	
	sub foo( byref bas as const string )
	end sub
	
	TEST( nonconst_arg )
		dim as string bar
		foo( bar )
	END_TEST
	
END_SUITE
