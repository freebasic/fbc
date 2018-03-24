#include "fbcunit.bi"

SUITE( fbc_tests.string_.strptr_ )

	TEST( all )
		dim as string ptr foo
		dim as string bar = "1234"
		dim as zstring ptr p

		foo = @bar
		p = strptr( *foo )
		CU_ASSERT_EQUAL( *p, "1234" )
	END_TEST
		
END_SUITE
