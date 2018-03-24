#include "fbcunit.bi"

SUITE( fbc_tests.string_.chr_0 )

	TEST( dynConstTest )

		dim null_value as integer = 0

		dim dyn_str_0 as string = chr(null_value)
		dim const_str_0 as string = chr(0)

		dim dyn_str_0123 as string = chr(null_value, 1, 2, 3)
		dim const_str_0123 as string = chr(0, 1, 2, 3)

		dim dyn_str_3210 as string = chr(3, 2, 1, null_value)
		dim const_str_3210 as string = chr(3, 2, 1, 0)

		CU_ASSERT_EQUAL( dyn_str_0, const_str_0 )
		CU_ASSERT_EQUAL( dyn_str_0123, const_str_0123 )
		CU_ASSERT_EQUAL( dyn_str_3210, const_str_3210 )

			'' The maximum number of arguments is 32
		dim const_str_long as string = chr( _
					48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, _
					64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79 _
			)
		CU_ASSERT_EQUAL( const_str_long, "0123456789:;<=>?@ABCDEFGHIJKLMNO" )

			'' Test case where internal escape codes are emitted (causing maximum
			'' internal representation length) during compile-time evaluation
		dim const_str_long2 as string = chr( _
					128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, _
					128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, _
					128, 128, 128, 128, 128, 128, 128, 128 _
			)
		CU_ASSERT_EQUAL( const_str_long2, !"\128\128\128\128\128\128\128\128\128\128\128\128\128" _
				!"\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128\128" )

	END_TEST

END_SUITE
