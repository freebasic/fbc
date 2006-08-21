#include "common.bi"

	CU_ASSERT( ns.test_1( ) = 1 )
	CU_ASSERT( ns.test_2( ) = 2 )
	
	CU_ASSERT( ns_cpp.test_1( ) = -1 )
	CU_ASSERT( ns_cpp.test_2( ) = -2 )	