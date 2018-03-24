#include "fbcunit.bi"

SUITE( fbc_tests.pointers.addr_deref )

	const TEST_VAL = 12345678

	TEST( derefAddressOfTest )

		dim as integer a, b
		dim as integer ptr p

		b = TEST_VAL

		a = *@b 
		CU_ASSERT( a = TEST_VAL )
		 
		p = @a
		CU_ASSERT( *p = TEST_VAL )

		p = @(a)
		CU_ASSERT( *p = TEST_VAL )

		p = @*p
		CU_ASSERT( *p = TEST_VAL )

	END_TEST

END_SUITE
