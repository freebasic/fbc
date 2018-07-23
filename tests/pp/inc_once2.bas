#include "fbcunit.bi"

SUITE( fbc_tests.pp.inc_once2 )

	TEST( test2 )

	  dim inc_counter2 as integer = 0

	#include "inc2.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	#include "../pp/inc2.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	#include "inc2.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	#include once "inc2.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	#include once "../pp/inc2.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	#include "inc2.bi"
	  CU_ASSERT_EQUAL( inc_counter2, 1 )

	END_TEST

END_SUITE
