# include "fbcunit.bi"

SUITE( fbc_tests.const_.typedef )

	TEST( test_enum )
		type foo as bar
		
		enum bar
			val1 = 1, val2 = 2, val3 = 3
		end enum
		
		CU_ASSERT_EQUAL( foo.val2, 2 )
		
	END_TEST

	TEST( test_type )
		type foo as bar
		
		type bar
			const val1 = 1, val2 = 2, val3 = 3
			pad as byte
		end type
		
		CU_ASSERT_EQUAL( foo.val2, 2 )
		
	END_TEST

END_SUITE