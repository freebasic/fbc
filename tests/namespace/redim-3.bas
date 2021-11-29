#include "fbcunit.bi"

common shared array1() as integer
common shared array2() as integer
dim shared array3() as integer
extern array4() as integer
dim array4() as integer

namespace ns
	private sub f1( )
		'' This should not redim the COMMON SHARED, separate namespace
		dim array1(1 to 1) as integer

		'' These should REDIM the globals though
		redim array2(1 to 1) as integer
		redim array3(1 to 1) as integer
		redim array4(1 to 1) as integer
	end sub

	private sub f2( )
		'' These REDIM the globals
		redim .array1(2 to 2) as integer
		redim .array2(2 to 2) as integer
		redim .array3(2 to 2) as integer
		redim .array4(2 to 2) as integer
	end sub
end namespace

private sub f3( )
	'' These should all REDIM though (same namespace)
	dim array1(3 to 3) as integer
	redim array2(3 to 3) as integer
	redim array3(3 to 3) as integer
	redim array4(3 to 3) as integer
end sub

private sub test_proc
	CU_ASSERT( lbound( array1 ) = 0 ) : CU_ASSERT( ubound( array1 ) = -1 )
	CU_ASSERT( lbound( array2 ) = 0 ) : CU_ASSERT( ubound( array2 ) = -1 )
	CU_ASSERT( lbound( array3 ) = 0 ) : CU_ASSERT( ubound( array3 ) = -1 )
	CU_ASSERT( lbound( array4 ) = 0 ) : CU_ASSERT( ubound( array4 ) = -1 )

	ns.f1( )

	CU_ASSERT( lbound( array1 ) = 0 ) : CU_ASSERT( ubound( array1 ) = -1 )
	CU_ASSERT( lbound( array2 ) = 1 ) : CU_ASSERT( ubound( array2 ) = 1 )
	CU_ASSERT( lbound( array3 ) = 1 ) : CU_ASSERT( ubound( array3 ) = 1 )
	CU_ASSERT( lbound( array4 ) = 1 ) : CU_ASSERT( ubound( array4 ) = 1 )

	ns.f2( )

	CU_ASSERT( lbound( array1 ) = 2 ) : CU_ASSERT( ubound( array1 ) = 2 )
	CU_ASSERT( lbound( array2 ) = 2 ) : CU_ASSERT( ubound( array2 ) = 2 )
	CU_ASSERT( lbound( array3 ) = 2 ) : CU_ASSERT( ubound( array3 ) = 2 )
	CU_ASSERT( lbound( array4 ) = 2 ) : CU_ASSERT( ubound( array4 ) = 2 )

	f3( )

	CU_ASSERT( lbound( array1 ) = 3 ) : CU_ASSERT( ubound( array1 ) = 3 )
	CU_ASSERT( lbound( array2 ) = 3 ) : CU_ASSERT( ubound( array2 ) = 3 )
	CU_ASSERT( lbound( array3 ) = 3 ) : CU_ASSERT( ubound( array3 ) = 3 )
	CU_ASSERT( lbound( array4 ) = 3 ) : CU_ASSERT( ubound( array4 ) = 3 )
end sub

SUITE( fbc_tests.namespace_.redim_3 )
	TEST( all )
		test_proc
	END_TEST
END_SUITE
