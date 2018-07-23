' TEST_MODE : FBCUNIT_COMPATIBLE

#include "fbcunit.bi"

/'
	To test code that is not in any namespace,
	only at module level in fbc's global namespace,
	the actual test needs to be placed out side of
	the SUITE()/END_SUITE block.

	The suite name typically has the form:
''	  SUITE( fbc_tests.<PATHNAME>.<FILENAME> )

'/

const x = -1

private sub module_level_proc()
	CU_ASSERT_TRUE( x )
end sub


SUITE( fbc_tests.pretest.style_module )
	TEST( module_level )
		module_level_proc()
	END_TEST
END_SUITE
