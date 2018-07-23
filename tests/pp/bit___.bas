#include "fbcunit.bi"

SUITE( fbc_tests.pp.bit___ )

	TEST( literals )
		
		CU_ASSERT( bit( 224, 0 ) = 0 )
		CU_ASSERT( bit( 224, 1 ) = 0 )
		CU_ASSERT( bit( 224, 2 ) = 0 )
		CU_ASSERT( bit( 224, 3 ) = 0 )
		CU_ASSERT( bit( 224, 4 ) = 0 )
		CU_ASSERT( bit( 224, 5 ) = -1 )
		CU_ASSERT( bit( 224, 6 ) = -1 )
		CU_ASSERT( bit( 224, 7 ) = -1 )
		CU_ASSERT( bit( 224, 8 ) = 0 )
		
	END_TEST
    
    TEST( longint_bit )
        
        for i as integer = 0 to 63
	        for j as integer = 0 to 63
				CU_ASSERT( bit( (1ull shl i), j ) = iif( i = j, -1, 0 ) )
			next
		next
        
        dim as longint ctx = any
        for i as integer = 0 to 63
	        for j as integer = 0 to 63
	        	ctx = 0
	        	ctx = bitset( ctx, j )
				CU_ASSERT( bit( ctx, j ) = -1 )
	        	ctx = bitreset( ctx, j )
				CU_ASSERT( bit( ctx, j ) = 0 )
			next
		next
    
    END_TEST

END_SUITE
