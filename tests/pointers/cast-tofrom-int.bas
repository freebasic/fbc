#include "fbcunit.bi"

SUITE( fbc_tests.pointers.cast_tofrom_int )

	TEST( all )
		dim as any ptr p
		CU_ASSERT( cint( p ) = 0 )
		CU_ASSERT( cuint( p ) = 0 )
		#ifdef __FB_64BIT__
			CU_ASSERT( clngint( p ) = 0 )
			CU_ASSERT( culngint( p ) = 0 )
		#else
			CU_ASSERT( clng( p ) = 0 )
			CU_ASSERT( culng( p ) = 0 )
		#endif

		dim as integer i
		dim as uinteger ui
		CU_ASSERT( cast( any ptr, i ) = 0 )
		CU_ASSERT( cast( any ptr, ui ) = 0 )
		#ifdef __FB_64BIT__
			dim as longint ll
			dim as ulongint ull
			CU_ASSERT( cast( any ptr, ll ) = 0 )
			CU_ASSERT( cast( any ptr, ull ) = 0 )
		#else
			dim as long l
			dim as ulong ul
			CU_ASSERT( cast( any ptr, l ) = 0 )
			CU_ASSERT( cast( any ptr, ul ) = 0 )
		#endif
	END_TEST

END_SUITE
