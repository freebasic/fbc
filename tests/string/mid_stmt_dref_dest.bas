#include "fbcunit.bi"

SUITE( fbc_tests.string_.mid_stmt_dref_dest )
        
    TEST( assignment )
    	dim as string f = " "
    	dim as string ptr g = @f
		if mid(*g, 1, 1) = " " then
			mid(*g, 1, 1) = "\"
		end if
		CU_ASSERT( *g = "\" )
	END_TEST
	
END_SUITE
