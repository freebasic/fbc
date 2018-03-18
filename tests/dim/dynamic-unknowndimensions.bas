#include "fbcunit.bi"

SUITE( fbc_tests.dim_.dynamic_unknowndimensions )

	TEST_GROUP( uboundDimensionCount )
		'' With the compiler tracking the dimension count of dynamic arrays
		'' at compile-time, check whether it doesn't get confused with
		'' allocated & unallocated dynamic arrays.
		dim shared array1() as integer

		private sub redimIt( )
			redim array1(0 to 0, 0 to 0, 0 to 0)
		end sub

		'' ubound() dimension count
		TEST( default )
			'' We've seen array1() being REDIM'ed to 3 dimensions, but at
			'' runtime it's unallocated here still.
			CU_ASSERT( ubound( array1, 0 ) = 0 )

			redimIt( )

			'' Now the allocated array has 3 dimensions
			CU_ASSERT( ubound( array1, 0 ) = 3 )

			dim array2() as integer
			CU_ASSERT( ubound( array2, 0 ) = 0 )

			redim array2(0 to 1)
			CU_ASSERT( ubound( array2, 0 ) = 1 )
		END_TEST
	END_TEST_GROUP

END_SUITE
