#include "fbcu.bi"
#include "common-shared-1.bi"

namespace fbc_tests.dim_.common_shared_2

private sub test cdecl( )
	'' Note: Assuming this test runs after common-1.bas
	CU_ASSERT( lbound( arrayi1 ) = 1 ) : CU_ASSERT( ubound( arrayi1 ) = 1 )
	CU_ASSERT( lbound( arrayi2 ) = 2 ) : CU_ASSERT( ubound( arrayi2 ) = 2 )
	CU_ASSERT( lbound( arrayi3 ) = 3 ) : CU_ASSERT( ubound( arrayi3 ) = 3 )
	CU_ASSERT( lbound( arrayi4 ) = 4 ) : CU_ASSERT( ubound( arrayi4 ) = 4 )
	CU_ASSERT( lbound( arrayi5 ) = 5 ) : CU_ASSERT( ubound( arrayi5 ) = 5 )
	CU_ASSERT( lbound( arrayi6 ) = 6 ) : CU_ASSERT( ubound( arrayi6 ) = 6 )
end sub

private sub ctor( ) constructor
	fbcu.add_suite( "tests/dim/common-shared-2" )
	fbcu.add_test( "test", @test )
end sub

end namespace
