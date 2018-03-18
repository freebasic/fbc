#include "fbcunit.bi"

SUITE( fbc_tests.numbers.cast_signed )

	TEST( all )
		dim as integer i, i0

		i0 = &hFF               : i = cbyte  ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
		i0 = &hFFFF             : i = cbyte  ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
		i0 = &hFFFF             : i = cshort ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
		i0 = &hFFFFFFFF         : i = cbyte  ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
		i0 = &hFFFFFFFF         : i = cshort ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
		i0 = &hFFFFFFFF         : i = clng   ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
	#ifdef __FB_64BIT__
		i0 = &hFFFFFFFFFFFFFFFF : i = cbyte  ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
		i0 = &hFFFFFFFFFFFFFFFF : i = cshort ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
		i0 = &hFFFFFFFFFFFFFFFF : i = clngint( i0 ) : CU_ASSERT( i = -1 ) : i = 0
		i0 = &hFFFFFFFFFFFFFFFF : i = cint   ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
	#else
		i0 = &hFFFFFFFF         : i = cint   ( i0 ) : CU_ASSERT( i = -1 ) : i = 0
	#endif

	END_TEST

END_SUITE
