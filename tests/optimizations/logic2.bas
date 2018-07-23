#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.logic2 )
	
	TEST( test1 )
		dim as string source = "this is a test"
		
		if instr("huh", source) > 0 and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if ( len(source) > 0 ) and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if len(source) > 0 and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	END_TEST
	
	TEST( test2 )
		if left("huh", 3) > "" and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if sin(3.14) > 0 and 0 then
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	END_TEST
	
	TEST( test3 )
		dim A as string
		A = "test 1..2..3..4...5..6...7..8...9..10"
		' print len(A) > 15 and 0  ' when this line is uncommented this part of the test succeeds,
		if len(A) > 15 and 0 then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
		
		if ( len(A) > 15 ) and 0 then 
			CU_ASSERT( 0 )
		else 
			CU_ASSERT( -1 )
		end if
	END_TEST
	
END_SUITE
