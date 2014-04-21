#include "fbcu.bi"

#include "common-shared.bi"

sub commonShared2Checks( )
	CU_ASSERT( lbound( arrayi1 ) = 1 ) : CU_ASSERT( ubound( arrayi1 ) = 1 )
	CU_ASSERT( lbound( arrayi2 ) = 2 ) : CU_ASSERT( ubound( arrayi2 ) = 2 )
	CU_ASSERT( lbound( arrayi3 ) = 3 ) : CU_ASSERT( ubound( arrayi3 ) = 3 )
	CU_ASSERT( lbound( arrayi4 ) = 4 ) : CU_ASSERT( ubound( arrayi4 ) = 4 )
	CU_ASSERT( lbound( arrayi5 ) = 5 ) : CU_ASSERT( ubound( arrayi5 ) = 5 )
	CU_ASSERT( lbound( arrayi6 ) = 6 ) : CU_ASSERT( ubound( arrayi6 ) = 6 )
end sub
