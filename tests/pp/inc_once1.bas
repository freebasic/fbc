#include "fbcunit.bi"

SUITE( fbc_tests.pp.inc_once1 )

	TEST( test1 )

	  dim inc_counter1 as integer = 0

	#include "inc1.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 1 )

	#include "inc1.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 2 )

	#include once "../pp/inc1.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 2 )

	#include once "../pp/inc1.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 2 )

	#include "../pp/inc1.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 3 )

	END_TEST

END_SUITE
