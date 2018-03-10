# include "fbcunit.bi"

SUITE( fbc_tests.compound.scope_ )

	const TEST_A = -1
	const TEST_B = -2
	const TEST_C = -3
	const TEST_D = -4

	declare sub proc ()

	dim shared c as integer = TEST_C
	dim shared d as integer = TEST_D
	
	TEST( test_scope )
		dim i as integer
		for i = 1 to 2
		
			scope
				dim a as integer = TEST_A
				scope 
					dim b as integer = TEST_B
					CU_ASSERT_EQUAL( a, TEST_A )
					scope
						CU_ASSERT_EQUAL( b, TEST_B )
					end scope
				end scope
		
			end scope
			
			scope
				dim a as integer = 1234
				CU_ASSERT_EQUAL( a, 1234 )
				scope
					CU_ASSERT_EQUAL( c, TEST_C )
					scope
						dim d as integer = 5678
						CU_ASSERT_EQUAL( d, 5678 )
					end scope
				end scope
			end scope
		
		next
		
		proc()
		
		CU_ASSERT_EQUAL( c, TEST_C )
		CU_ASSERT_EQUAL( d, TEST_D )
		
	END_TEST

	sub proc ()

		dim i as integer
		for i = 1 to 2

			scope
				dim a as integer = TEST_A
				scope 
					dim b as integer = TEST_B
					CU_ASSERT_EQUAL( a, TEST_A )
					scope
						CU_ASSERT_EQUAL( b, TEST_B )
					end scope
				end scope
			end scope
			
			scope
				dim a as integer = 1234
				CU_ASSERT_EQUAL( a, 1234 )
				scope
					CU_ASSERT_EQUAL( c, TEST_C )
					scope
						dim d as integer = 5678
						CU_ASSERT_EQUAL( d, 5678 )
					end scope
				end scope
			end scope
			
			CU_ASSERT_EQUAL( c, TEST_C )
			CU_ASSERT_EQUAL( d, TEST_D )
			
		next

	end sub

END_SUITE
