# include "fbcunit.bi"

SUITE( fbc_tests.compound.scope_array )

	const TEST_1 = -1
	const TEST_2 = -2
	const TEST_3 = -3

	type bar
		a as short
		b as integer
		c as single
	end type
		
	declare sub proc ()

		dim shared array(0 to 3) as bar = { (TEST_1) }
		
	TEST( test_scope_array )

		scope		
			scope 
				dim array(0 to 3) as bar = { (TEST_2) }
				scope
					CU_ASSERT_EQUAL( array(0).a, TEST_2 )
				end scope
			end scope
			CU_ASSERT_EQUAL( array(0).a, TEST_1 )
		end scope
		
		scope		
			scope
				scope
					dim array(0 to 3) as bar = { (TEST_3) }
				end scope
				CU_ASSERT_EQUAL( array(0).a, TEST_1 )
			end scope
		end scope
		
		proc()
		
		CU_ASSERT_EQUAL( array(0).a, TEST_1 )
		
	END_TEST

	''::::
	sub proc ()

		scope		
			scope 
				dim array(0 to 3) as bar = { (TEST_2) }
				scope
					CU_ASSERT_EQUAL( array(0).a, TEST_2 )
				end scope
			end scope
			CU_ASSERT_EQUAL( array(0).a, TEST_1 )
		end scope
		
		scope		
			scope
				scope
					dim array(0 to 3) as bar = { (TEST_3) }
				end scope
				CU_ASSERT_EQUAL( array(0).a, TEST_1 )
			end scope
		end scope
		
		CU_ASSERT_EQUAL( array(0).a, TEST_1 )

	end sub

END_SUITE
