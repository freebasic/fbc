#include "fbcunit.bi"

SUITE( fbc_tests.pointers.multi_deref )

	const TEST_VAL = &hDeadBeef
		
	TEST( all )

		dim i as integer, v as integer
		dim p as integer ptr
		dim pp as integer ptr ptr
		
		pp = @p
		p = @v
		v = TEST_VAL
		
		i = 0
		
		CU_ASSERT_EQUAL( pp[i][i], TEST_VAL )
		CU_ASSERT_EQUAL( **pp, TEST_VAL )
		CU_ASSERT_EQUAL( **(pp+i), TEST_VAL )
		CU_ASSERT_EQUAL( *(pp+i)[i], TEST_VAL )
		
	END_TEST

END_SUITE
