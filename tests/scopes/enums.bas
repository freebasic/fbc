#include "fbcunit.bi"

'//
'// test for enums defined locally
'//

SUITE( fbc_tests.scopes.enums )

	TEST( test1 )
		enum foo: foo_val = 3: end enum
		CU_ASSERT_EQUAL( foo_val, 3 )
	END_TEST

	TEST( test2 )
		enum foo: foo_val = 4: end enum
		CU_ASSERT_EQUAL( foo_val, 4 )
	END_TEST

	TEST( test3 )
		scope
			enum foo: foo_val = 1: end enum
			CU_ASSERT_EQUAL( foo_val, 1 )
		end scope

		scope
			enum foo: foo_val = 2: end enum
			CU_ASSERT_EQUAL( foo_val, 2 )
		end scope
	END_TEST

END_SUITE
