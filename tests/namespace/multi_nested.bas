#include "fbcunit.bi"

const TEST_VAL = 1234

namespace nested.multi.lev1.lev2.lev3.lev4.lev5

	dim shared as integer value = TEST_VAL

end namespace

SUITE( fbc_tests.namespace_.multi_nested )

	TEST( nested1 )
		CU_ASSERT( nested.multi.lev1.lev2.lev3.lev4.lev5.value = TEST_VAL )
	END_TEST

	TEST( nested2 )
		using nested.multi.lev1
		CU_ASSERT( lev2.lev3.lev4.lev5.value = TEST_VAL )
	END_TEST

	TEST( nested3 )
		using nested.multi.lev1.lev2
		CU_ASSERT( lev3.lev4.lev5.value = TEST_VAL )
	END_TEST

	TEST( nested4 )
		using nested.multi.lev1.lev2.lev3
		CU_ASSERT( lev4.lev5.value = TEST_VAL )
	END_TEST

	TEST( nested5 )
		using nested.multi.lev1.lev2.lev3.lev4
		CU_ASSERT( lev5.value = TEST_VAL )
	END_TEST

	TEST( nested6 )
		using nested.multi.lev1.lev2.lev3.lev4.lev5
		CU_ASSERT( value = TEST_VAL )
	END_TEST

END_SUITE
