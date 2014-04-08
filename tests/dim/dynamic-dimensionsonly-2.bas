#include "fbcu.bi"

namespace fbc_tests.dim_.dynamic_dimensionsonly

#include "dynamic-dimensionsonly.bi"

private sub test cdecl( )
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
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/dynamic-dimensionsonly-2" )
	fbcu.add_test( "test", @test )
end sub

end namespace
