#include "fbcunit.bi"

SUITE( fbc_tests.pp.inc_once2_self )

	TEST( self2 )

	  dim inc_counter2 as integer = 0

	#include "inc2self.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	#include "inc2self.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	#include once "inc2self.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	#include once "inc2self.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	#include "inc2self.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	END_TEST

END_SUITE
