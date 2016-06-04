#include "fbcu.bi"

#include "common-shared.bi"

'' REDIM'ing a COMMON (dynamic) array
'' Note: DIM works like REDIM for COMMONs; SHARED is mostly ignored

'' REDIMs from here are emitted into the modlevel procedure
dim          arrayi1(1 to 1) as integer
dim shared   arrayi2(2 to 2) as integer
redim        arrayi3(3 to 3) as integer
redim shared arrayi4(4 to 4) as integer

private sub f( )
	'' Scoped REDIMs are emitted in their scope.
	'' SHARED isn't allowed here in this case.
	dim arrayi5(5 to 5) as integer
	redim arrayi6(6 to 6) as integer
end sub

private sub test cdecl( )
	CU_ASSERT( lbound( arrayi1 ) = 1 ) : CU_ASSERT( ubound( arrayi1 ) = 1 )
	CU_ASSERT( lbound( arrayi2 ) = 2 ) : CU_ASSERT( ubound( arrayi2 ) = 2 )
	CU_ASSERT( lbound( arrayi3 ) = 3 ) : CU_ASSERT( ubound( arrayi3 ) = 3 )
	CU_ASSERT( lbound( arrayi4 ) = 4 ) : CU_ASSERT( ubound( arrayi4 ) = 4 )
	CU_ASSERT( lbound( arrayi5 ) = 0 ) : CU_ASSERT( ubound( arrayi5 ) = -1 )
	CU_ASSERT( lbound( arrayi6 ) = 0 ) : CU_ASSERT( ubound( arrayi6 ) = -1 )
	f( )
	CU_ASSERT( lbound( arrayi1 ) = 1 ) : CU_ASSERT( ubound( arrayi1 ) = 1 )
	CU_ASSERT( lbound( arrayi2 ) = 2 ) : CU_ASSERT( ubound( arrayi2 ) = 2 )
	CU_ASSERT( lbound( arrayi3 ) = 3 ) : CU_ASSERT( ubound( arrayi3 ) = 3 )
	CU_ASSERT( lbound( arrayi4 ) = 4 ) : CU_ASSERT( ubound( arrayi4 ) = 4 )
	CU_ASSERT( lbound( arrayi5 ) = 5 ) : CU_ASSERT( ubound( arrayi5 ) = 5 )
	CU_ASSERT( lbound( arrayi6 ) = 6 ) : CU_ASSERT( ubound( arrayi6 ) = 6 )

	commonShared2Checks( )
end sub

namespace shadowingACommon
	common shared i as integer

	private sub test cdecl( )
		CU_ASSERT( i = 0 )
		i = 1
		CU_ASSERT( i = 1 )

		scope
			dim i as integer
			CU_ASSERT( i = 0 )
			i = 2
			CU_ASSERT( i = 2 )
		end scope
		CU_ASSERT( i = 1 )

		dim i as integer
		CU_ASSERT( i = 0 )
		i = 2
		CU_ASSERT( i = 2 )
	end sub
end namespace

private sub ctor( ) constructor
	fbcu.add_suite( "fbc_tests.dim.common-shared-1" )
	fbcu.add_test( "test", @test )
	fbcu.add_test( "shadowing a COMMON", @shadowingACommon.test )
end sub
