#include "fbcunit.bi"

'' See:
''    dynamic-dimensionsonly.bi
''    dynamic-dimensionsonly-1.bas
''    dynamic-dimensionsonly-2.bas

namespace dynamic_dimensionsonly
	#include "dynamic-dimensionsonly.bi"
end namespace

SUITE( fbc_tests.dim_.dynamic_dimensionsonly_2 )

	using dynamic_dimensionsonly

	TEST( proc_2 )
		CU_ASSERT( ubound( array1, 0 ) = 0 )
		CU_ASSERT( lbound( array1 ) = 0 )
		CU_ASSERT( ubound( array1 ) = -1 )
		redim array1(0 to 1)
		CU_ASSERT( ubound( array1, 0 ) = 1 )
		CU_ASSERT( lbound( array1 ) = 0 )
		CU_ASSERT( ubound( array1 ) = 1 )

		CU_ASSERT( ubound( array2, 0 ) = 0 )
		CU_ASSERT( lbound( array2, 1 ) = 0 )
		CU_ASSERT( ubound( array2, 1 ) = -1 )
		CU_ASSERT( lbound( array2, 2 ) = 0 )
		CU_ASSERT( ubound( array2, 2 ) = -1 )
		redim array2(1 to 1, 2 to 2)
		CU_ASSERT( ubound( array2, 0 ) = 2 )
		CU_ASSERT( lbound( array2, 1 ) = 1 )
		CU_ASSERT( ubound( array2, 1 ) = 1 )
		CU_ASSERT( lbound( array2, 2 ) = 2 )
		CU_ASSERT( ubound( array2, 2 ) = 2 )

		erase array1
		erase array2
	END_TEST

END_SUITE
