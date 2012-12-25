# include "fbcu.bi"

namespace fbc_tests.optimizations.array_bound

dim shared array1(0 to 1) as integer
dim shared array2(123 to 456) as integer
dim shared array3(-57 to -13) as integer
dim shared array4(-25 to 25) as integer
dim shared array5(10 to 11, 20 to 21, 30 to 31) as integer
dim shared array6() as integer

'' lbound/ubound on fixed-size array should be evaluated as constants
const ARRAY1_L = lbound( array1 )
const ARRAY1_U = ubound( array1 )
const ARRAY2_L = lbound( array2 )
const ARRAY2_U = ubound( array2 )
const ARRAY3_L = lbound( array3 )
const ARRAY3_U = ubound( array3 )
const ARRAY4_L = lbound( array4 )
const ARRAY4_U = ubound( array4 )
const ARRAY51_L = lbound( array5, 1 )
const ARRAY51_U = ubound( array5, 1 )
const ARRAY52_L = lbound( array5, 2 )
const ARRAY52_U = ubound( array5, 2 )
const ARRAY53_L = lbound( array5, 3 )
const ARRAY53_U = ubound( array5, 3 )

sub test1 cdecl( )
	CU_ASSERT( ARRAY1_L = 0 )
	CU_ASSERT( ARRAY1_U = 1 )
	CU_ASSERT( ARRAY2_L = 123 )
	CU_ASSERT( ARRAY2_U = 456 )
	CU_ASSERT( ARRAY3_L = -57 )
	CU_ASSERT( ARRAY3_U = -13 )
	CU_ASSERT( ARRAY4_L = -25 )
	CU_ASSERT( ARRAY4_U = 25 )
	CU_ASSERT( ARRAY51_L = 10 )
	CU_ASSERT( ARRAY51_U = 11 )
	CU_ASSERT( ARRAY52_L = 20 )
	CU_ASSERT( ARRAY52_U = 21 )
	CU_ASSERT( ARRAY53_L = 30 )
	CU_ASSERT( ARRAY53_U = 31 )

	'' Un-allocated dynamic array
	CU_ASSERT( lbound( array6, 0 ) = 1 )
	CU_ASSERT( ubound( array6, 0 ) = 0 )
	CU_ASSERT( lbound( array6 ) = 1 )
	CU_ASSERT( ubound( array6 ) = 0 )
	CU_ASSERT( lbound( array6, -1 ) = 1 )
	CU_ASSERT( ubound( array6, -1 ) = 0 )
	CU_ASSERT( lbound( array6, -123 ) = 1 )
	CU_ASSERT( ubound( array6, -123 ) = 0 )
	CU_ASSERT( lbound( array6, 1 ) = 1 )
	CU_ASSERT( ubound( array6, 1 ) = 0 )
	CU_ASSERT( lbound( array6, 123 ) = 1 )
	CU_ASSERT( ubound( array6, 123 ) = 0 )

	redim array6(10 to 11)
	CU_ASSERT( lbound( array6, 0 ) = 1 )
	CU_ASSERT( ubound( array6, 0 ) = 1 )
	CU_ASSERT( lbound( array6 ) = 10 )
	CU_ASSERT( ubound( array6 ) = 11 )
	CU_ASSERT( lbound( array6, -1 ) = 1 )
	CU_ASSERT( ubound( array6, -1 ) = 0 )
	CU_ASSERT( lbound( array6, -123 ) = 1 )
	CU_ASSERT( ubound( array6, -123 ) = 0 )
	CU_ASSERT( lbound( array6, 1 ) = 10 )
	CU_ASSERT( ubound( array6, 1 ) = 11 )
	CU_ASSERT( lbound( array6, 123 ) = 1 )
	CU_ASSERT( ubound( array6, 123 ) = 0 )

	dim array7() as integer
	CU_ASSERT( lbound( array7, 0 ) = 1 )
	CU_ASSERT( ubound( array7, 0 ) = 0 )
	CU_ASSERT( lbound( array7 ) = 1 )
	CU_ASSERT( ubound( array7 ) = 0 )
	CU_ASSERT( lbound( array7, -1 ) = 1 )
	CU_ASSERT( ubound( array7, -1 ) = 0 )
	CU_ASSERT( lbound( array7, -123 ) = 1 )
	CU_ASSERT( ubound( array7, -123 ) = 0 )
	CU_ASSERT( lbound( array7, 1 ) = 1 )
	CU_ASSERT( ubound( array7, 1 ) = 0 )
	CU_ASSERT( lbound( array7, 123 ) = 1 )
	CU_ASSERT( ubound( array7, 123 ) = 0 )

	redim array7(10 to 11, 20 to 21, 30 to 31, 40 to 41)
	CU_ASSERT( lbound( array7, 0 ) = 1 )
	CU_ASSERT( ubound( array7, 0 ) = 4 )
	CU_ASSERT( lbound( array7 ) = 10 )
	CU_ASSERT( ubound( array7 ) = 11 )
	CU_ASSERT( lbound( array7, -1 ) = 1 )
	CU_ASSERT( ubound( array7, -1 ) = 0 )
	CU_ASSERT( lbound( array7, -123 ) = 1 )
	CU_ASSERT( ubound( array7, -123 ) = 0 )
	CU_ASSERT( lbound( array7, 1 ) = 10 )
	CU_ASSERT( ubound( array7, 1 ) = 11 )
	CU_ASSERT( lbound( array7, 2 ) = 20 )
	CU_ASSERT( ubound( array7, 2 ) = 21 )
	CU_ASSERT( lbound( array7, 3 ) = 30 )
	CU_ASSERT( ubound( array7, 3 ) = 31 )
	CU_ASSERT( lbound( array7, 4 ) = 40 )
	CU_ASSERT( ubound( array7, 4 ) = 41 )
	CU_ASSERT( lbound( array7, 123 ) = 1 )
	CU_ASSERT( ubound( array7, 123 ) = 0 )

	redim array8(10 to 11, 20 to 21) as integer
	CU_ASSERT( lbound( array8, 0 ) = 1 )
	CU_ASSERT( ubound( array8, 0 ) = 2 )
	CU_ASSERT( lbound( array8 ) = 10 )
	CU_ASSERT( ubound( array8 ) = 11 )
	CU_ASSERT( lbound( array8, -1 ) = 1 )
	CU_ASSERT( ubound( array8, -1 ) = 0 )
	CU_ASSERT( lbound( array8, -123 ) = 1 )
	CU_ASSERT( ubound( array8, -123 ) = 0 )
	CU_ASSERT( lbound( array8, 1 ) = 10 )
	CU_ASSERT( ubound( array8, 1 ) = 11 )
	CU_ASSERT( lbound( array8, 2 ) = 20 )
	CU_ASSERT( ubound( array8, 2 ) = 21 )
	CU_ASSERT( lbound( array8, 123 ) = 1 )
	CU_ASSERT( ubound( array8, 123 ) = 0 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/optimizations/array-bound" )
	fbcu.add_test( "1", @test1 )
end sub

end namespace
