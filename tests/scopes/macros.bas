#include "fbcunit.bi"

'//
'// test for macros defined locally
'//

SUITE( fbc_tests.scopes.macros )

	TEST( test1 )
		#define foo(x) x
		CU_ASSERT_EQUAL( foo(3), 3 )
	END_TEST

	TEST( test2 )
		#define foo(x) x
		CU_ASSERT_EQUAL( foo(4), 4 )
	END_TEST

	TEST( test3 )
		scope
			#define foo(x) x
			CU_ASSERT_EQUAL( foo(1), 1 )
		end scope

		scope
			#define foo(x) x
			CU_ASSERT_EQUAL( foo(2), 2 )
		end scope
	END_TEST

END_SUITE
