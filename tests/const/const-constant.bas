#include "fbcunit.bi"

SUITE( fbc_tests.const_.const_constant )

	const N_ULL  as       ulongint = &hAABBCCDDAAAABBBBull
	const N_CULL as const ulongint = &hAABBCCDDAAAABBBBull

	const N_F    as       single   = 1.5
	const N_CF   as const single   = 1.5

	const N_D    as       double   = 1.5
	const N_CD   as const double   = 1.5

	TEST( constant )
		CU_ASSERT( N_ULL  = &hAABBCCDDAAAABBBBull )
		CU_ASSERT( N_CULL = &hAABBCCDDAAAABBBBull )

		CU_ASSERT( N_F  = 1.5 )
		CU_ASSERT( N_CF = 1.5 )

		CU_ASSERT( N_D  = 1.5 )
		CU_ASSERT( N_CD = 1.5 )
	END_TEST

END_SUITE
