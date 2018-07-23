# include "fbcunit.bi"

SUITE( fbc_tests.const_.ptrassign )
	
	TEST( test_ptr )
		dim as const integer a = 0
		dim as const integer ptr b
		dim as const integer ptr ptr c 
		
		b = @a
		c = @b
		*c = @a
	END_TEST
	
END_SUITE
