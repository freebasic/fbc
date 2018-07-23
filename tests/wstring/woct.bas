#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.woct_ )

	TEST( long_ )
		const TEST_VAL as ulongint = &o1777777777777777777777ULL
		
		dim as ulongint		n = TEST_VAL
		dim as ulongint		digmax = 8ULL
		dim as integer		i
			
		CU_ASSERT( valulng( "&o" + woct( n ) ) = TEST_VAL )
		
		for i = 1 to ((len( n ) * 8) \ 3) + 0
		    CU_ASSERT( valulng( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
		    digmax *= 8
		next
		
		CU_ASSERT( valulng( "&o" + woct( n, i ) ) = TEST_VAL )
		
	END_TEST
	
	TEST( integer_ )
		const TEST_VAL = &o17777777777
		
		dim as uinteger n = TEST_VAL, digmax = 8
		dim as integer i
			
		CU_ASSERT( valuint( "&o" + woct( n ) ) = TEST_VAL )
		
		for i = 1 to ((len( n ) * 8) \ 3) + 0
		    CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
		    digmax *= 8
		next
		
		CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL )
		
	END_TEST
	
	TEST( short_ )
		const TEST_VAL = &o177777
		
		dim as ushort n = TEST_VAL, digmax = 8
		dim as integer i
			
		CU_ASSERT( valuint( "&o" + woct( n ) ) = TEST_VAL )
		
		for i = 1 to ((len( n ) * 8) \ 3) + 0
		    CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
		    digmax *= 8
		next
		
		CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL )
		
	END_TEST
	
	TEST( byte_ )
		const TEST_VAL = &o377
		
		dim as ubyte n = TEST_VAL, digmax = 8
		dim as integer i
			
		CU_ASSERT( valuint( "&o" + woct( n ) ) = TEST_VAL )
		
		for i = 1 to ((len( n ) * 8) \ 3) + 0
		    CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL mod digmax )
		    digmax *= 8
		next
		
		CU_ASSERT( valuint( "&o" + woct( n, i ) ) = TEST_VAL )
		
	END_TEST
	
END_SUITE
