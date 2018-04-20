#include "fbcunit.bi"

'' See:
''    dynamic-dimensionsonly.bi
''    dynamic-dimensionsonly-1.bas
''    dynamic-dimensionsonly-2.bas

namespace dynamic_dimensionsonly
	#include "dynamic-dimensionsonly.bi"

	dim array1(any) as integer
	dim array2(any, any) as integer

	dim shared array3(any, any, any) as integer
end namespace

SUITE( fbc_tests.dim_.dynamic_dimensionsonly_1 )

	using dynamic_dimensionsonly

	TEST( proc_1 )

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

		CU_ASSERT( ubound( array3, 0 ) = 0 )
		CU_ASSERT( lbound( array3, 1 ) = 0 )
		CU_ASSERT( ubound( array3, 1 ) = -1 )
		CU_ASSERT( lbound( array3, 2 ) = 0 )
		CU_ASSERT( ubound( array3, 2 ) = -1 )
		CU_ASSERT( lbound( array3, 3 ) = 0 )
		CU_ASSERT( ubound( array3, 3 ) = -1 )
		redim array3(1 to 1, 2 to 2, 3 to 3)
		CU_ASSERT( ubound( array3, 0 ) = 3 )
		CU_ASSERT( lbound( array3, 1 ) = 1 )
		CU_ASSERT( ubound( array3, 1 ) = 1 )
		CU_ASSERT( lbound( array3, 2 ) = 2 )
		CU_ASSERT( ubound( array3, 2 ) = 2 )
		CU_ASSERT( lbound( array3, 3 ) = 3 )
		CU_ASSERT( ubound( array3, 3 ) = 3 )

		dim array4(any) as integer

		CU_ASSERT( ubound( array4, 0 ) = 0 )
		CU_ASSERT( lbound( array4 ) = 0 )
		CU_ASSERT( ubound( array4 ) = -1 )
		redim array4(0 to 1)
		CU_ASSERT( ubound( array4, 0 ) = 1 )
		CU_ASSERT( lbound( array4 ) = 0 )
		CU_ASSERT( ubound( array4 ) = 1 )

		erase array1
		erase array2

	END_TEST

END_SUITE
