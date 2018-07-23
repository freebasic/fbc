#include "fbcunit.bi"

SUITE( fbc_tests.overload_.rtl_str )

	TEST( all )
		dim s as string = "13"
		dim cs as const string = "24"

		CU_ASSERT( val    ( s ) = 13 )
		CU_ASSERT( valint ( s ) = 13 )
		CU_ASSERT( valuint( s ) = 13 )
		CU_ASSERT( vallng ( s ) = 13 )
		CU_ASSERT( valulng( s ) = 13 )

		CU_ASSERT( val    ( cs ) = 24 )
		CU_ASSERT( valint ( cs ) = 24 )
		CU_ASSERT( valuint( cs ) = 24 )
		CU_ASSERT( vallng ( cs ) = 24 )
		CU_ASSERT( valulng( cs ) = 24 )

		CU_ASSERT(  left( s, 1 ) = "1" )
		CU_ASSERT( right( s, 1 ) = "3" )

		CU_ASSERT(  left( cs, 1 ) = "2" )
		CU_ASSERT( right( cs, 1 ) = "4" )
	END_TEST

END_SUITE
