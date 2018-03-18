#include "fbcunit.bi"

SUITE( fbc_tests.quirk.data_fwd2 )

	TEST( all )
		
		'' blank restore, no DATA's parsed yet
		restore 
        
		for i as integer = 1 to 6
			dim as integer value
			read value
			CU_ASSERT_EQUAL( i, value )
		next

	END_TEST

END_SUITE

data 1
data 2, 3
data 4, 5, 6
