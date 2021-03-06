#include "fbcunit.bi"

'' file saved in ule16

SUITE( fbc_tests.wstring_.literal )

	TEST( escaped )
		scope
			dim wr as wstring * 10 = ""
			wr = wstr( !"\11123\123\255" )
			
			CU_ASSERT_EQUAL( wr[0], 11123 )
			CU_ASSERT_EQUAL( wr[1], 123 )
			CU_ASSERT_EQUAL( wr[2], 255 )

		end scope

	END_TEST

END_SUITE
