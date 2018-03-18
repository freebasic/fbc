#include "fbcunit.bi"

SUITE( fbc_tests.quirk.data_fwd )

	TEST( integer_ )
		dim as integer i, v

		restore data_1
		for i = 1 to 6
			read v
			CU_ASSERT_EQUAL( v, i )
		next
		
	END_TEST

	TEST( string_ )
		dim as integer i
		dim as string v

		restore data_2
		for i = 1 to 6
			read v
			CU_ASSERT_EQUAL( v, str(-i) )
		next

	END_TEST

	TEST( float )
		dim as integer i
		dim as double v

		restore data_3
		for i = 1 to 6
			read v
			CU_ASSERT_EQUAL( v, i/2 )
		next

	END_TEST

END_SUITE

data_1:
data 1
data 2, 3
data 4, 5, 6

data_2:
data "-1"
data "-2", "-3"
data "-4", "-5", "-6"

data_3:
data 1/2, 2/2, 3/2, 4/2, 5/2, 6/2
