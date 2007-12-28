' TEST_MODE : MULTI_MODULE_TEST

#include "common.bi"

  ASSERT( ns.test_1( ) = 1 )
  ASSERT( ns.test_2( ) = 2 )
	
  ASSERT( ns_cpp.test_1( ) = -1 )
  ASSERT( ns_cpp.test_2( ) = -2 ) 
