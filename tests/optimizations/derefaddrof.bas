#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.derefaddrof )

	TEST( all )
		dim as byte b(0 to 2) = {11, -22, 33}

		'' Regression test for hOptDerefAddr()/astIncOffset()
		CU_ASSERT(*(@cast(ubyte, b(0)) + 1) = cubyte(-22))

		dim as integer ptr p = callocate(sizeof(integer) * 5)
		for i as integer = 0 to 4
			p[i] = i
			CU_ASSERT(p[i] = i)
		next
		CU_ASSERT(p[0] = 0)
		CU_ASSERT(p[1] = 1)
		CU_ASSERT(p[2] = 2)
		CU_ASSERT(p[3] = 3)
		CU_ASSERT(p[4] = 4)
		deallocate(p)
	END_TEST

END_SUITE
