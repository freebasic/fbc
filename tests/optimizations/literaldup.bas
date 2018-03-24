#include "fbcunit.bi"

SUITE( fbc_tests.optimizations.literaldup )

	function str1 as any ptr
		function = @"common lit string"
	end function

	function str2 as any ptr
		function = @"common lit string"
	end function

	TEST( literal_reuse )
		CU_ASSERT_EQUAL( str1, str2 )
	END_TEST

END_SUITE
