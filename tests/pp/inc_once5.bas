#include "fbcunit.bi"

SUITE( fbc_tests.pp.inc_once5 )

	TEST( test5 )

	  dim inc_counter1 as integer = 0
	  dim inc_counter2 as integer = 0
	  dim inc_counter3 as integer = 0
	  dim inc_counter4 as integer = 0
	  dim inc_counter5 as integer = 0

	#include "inc5.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 4 )
	  CU_ASSERT_EQUAL( inc_counter2, 1 )
	  CU_ASSERT_EQUAL( inc_counter3, 2 )
	  CU_ASSERT_EQUAL( inc_counter4, 1 )
	  CU_ASSERT_EQUAL( inc_counter5, 1 )

	#include "inc5.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 6 )
	  CU_ASSERT_EQUAL( inc_counter2, 1 )
	  CU_ASSERT_EQUAL( inc_counter3, 3 )
	  CU_ASSERT_EQUAL( inc_counter4, 1 )
	  CU_ASSERT_EQUAL( inc_counter5, 2 )

	#include once "inc5.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 6 )
	  CU_ASSERT_EQUAL( inc_counter2, 1 )
	  CU_ASSERT_EQUAL( inc_counter3, 3 )
	  CU_ASSERT_EQUAL( inc_counter4, 1 )
	  CU_ASSERT_EQUAL( inc_counter5, 2 )

	#include once "../pp/inc5.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 6 )
	  CU_ASSERT_EQUAL( inc_counter2, 1 )
	  CU_ASSERT_EQUAL( inc_counter3, 3 )
	  CU_ASSERT_EQUAL( inc_counter4, 1 )
	  CU_ASSERT_EQUAL( inc_counter5, 2 )

	#include "inc5.bi"
	  CU_ASSERT_EQUAL( inc_counter1, 8 )
	  CU_ASSERT_EQUAL( inc_counter2, 1 )
	  CU_ASSERT_EQUAL( inc_counter3, 4 )
	  CU_ASSERT_EQUAL( inc_counter4, 1 )
	  CU_ASSERT_EQUAL( inc_counter5, 3 )

	END_TEST

END_SUITE
