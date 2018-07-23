#include "fbcunit.bi"

'//
'// test for constants defined locally
'//

SUITE( fbc_tests.scopes.consts )

	TEST( test1 )
		const foo = 3
		CU_ASSERT_EQUAL( foo, 3 )
	END_TEST

	TEST( test2 )
		const foo = 4
		CU_ASSERT_EQUAL( foo, 4 )
	END_TEST

	TEST( test3 )
		scope
			const foo = 1
			CU_ASSERT_EQUAL( foo, 1 )
		end scope

		scope
			const foo = 2
			CU_ASSERT_EQUAL( foo, 2 )
		end scope
	END_TEST

END_SUITE
