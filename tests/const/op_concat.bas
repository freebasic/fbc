# include "fbcunit.bi"

SUITE( fbc_tests.const_.op_concat )
	
	TEST( concat )
		
		dim as const string foo = "hello"
		dim as string bar
		
		for i as integer = 0 to 3
			bar = bar & foo
		next
		
		CU_ASSERT( bar = "hellohellohellohello" )
		
	END_TEST
	
END_SUITE
