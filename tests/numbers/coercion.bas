#include "fbcunit.bi"

SUITE( fbc_tests.numbers.coercion )

	#define TEST_SI &hFFFFFFFF
	#define TEST_UI &hFFFFFFFFU
	#define TEST_SL &hFFFFFFFFFFFFFFFFLL
	#define TEST_UL &hFFFFFFFFFFFFFFFFLL
	#define TEST_S  csng(123456.7)
	#define TEST_D  cdbl(12345678901234.5)

	TEST( longint_ )
		dim as longint v
		v = TEST_SI
		CU_ASSERT( v = TEST_SI )
		v = TEST_UI
		CU_ASSERT( v = TEST_UI )
		v = TEST_SL
		CU_ASSERT( v = TEST_SL )
		v = TEST_UL
		CU_ASSERT( v = TEST_UL )
		v = TEST_S
		CU_ASSERT( v = cast( longint, TEST_S ) )
		v = TEST_D
		CU_ASSERT( v = cast( longint, TEST_D ) )
	END_TEST

	TEST( unlongint_ )
		dim as ulongint v
		v = TEST_SI
		CU_ASSERT( v = TEST_SI )
		v = TEST_UI
		CU_ASSERT( v = TEST_UI )
		v = TEST_SL
		CU_ASSERT( v = TEST_SL )
		v = TEST_UL
		CU_ASSERT( v = TEST_UL )
		v = TEST_S
		CU_ASSERT( v = cast( ulongint, TEST_S ) )
		v = TEST_D
		CU_ASSERT( v = cast( ulongint, TEST_D ) )
	END_TEST

	TEST( integer_ )
		dim as integer v
		v = TEST_SI
		CU_ASSERT( v = TEST_SI )
		v = TEST_UI
		CU_ASSERT( v = TEST_UI )
		v = TEST_SL
		CU_ASSERT( v = cast( integer, TEST_SL ) )
		v = TEST_UL
		CU_ASSERT( v = cast( integer, TEST_UL ) )
		v = TEST_S
		CU_ASSERT( v = cast( integer, TEST_S ) )
		v = TEST_D
		CU_ASSERT( v = cast( integer, TEST_D ) )
	END_TEST

	TEST( uinteger_ )
		dim as uinteger v
		v = TEST_SI
		CU_ASSERT( v = TEST_SI )
		v = TEST_UI
		CU_ASSERT( v = TEST_UI )
		v = TEST_SL
		CU_ASSERT( v = cast( uinteger, TEST_SL ) )
		v = TEST_UL
		CU_ASSERT( v = cast( uinteger, TEST_UL ) )
		v = TEST_S
		CU_ASSERT( v = cast( uinteger, TEST_S ) )
		v = TEST_D
		CU_ASSERT( v = cast( uinteger, TEST_D ) )
	END_TEST

END_SUITE
