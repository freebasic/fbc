#include "fbcunit.bi"

SUITE( fbc_tests.pointers.indexing2 )

	dim shared dp as integer pointer pointer 
	dim shared array(0 to 4) as integer 

	TEST( index )

		*dp = @array(0) 
  
		dim i as integer
		for i = 0 to 4 
  			CU_ASSERT_EQUAL( *(*dp + i), i )
		next 

	END_TEST

	SUITE_INIT
		dim i as integer
		for i = 0 to 4 
  			array(i) = i 
		next 

		dp = allocate( len(integer pointer pointer) ) 
		if (0 = dp) then return -1
		*dp = allocate( len(integer pointer) ) 
		if (0 = *dp) then return -1

		return 0
	END_SUITE_INIT

	SUITE_CLEANUP
	'	!!! TODO !!!
	'   why is this commented out?

	'	deallocate (*dp)
	'	deallocate (dp)
		return 0
	END_SUITE_CLEANUP

END_SUITE
