# include "fbcunit.bi"

SUITE( fbc_tests.compound.continue_mult )

	TEST( test_for )
		dim as integer cnt = 0
		
		for i as integer = 1 to 1
			for j as integer = 1 to 1
				cnt += 1
				continue for, for
				cnt += 1
			next
			cnt += 1
		next
		
		CU_ASSERT_EQUAL( cnt, 1 )
	END_TEST

	TEST( test_do )
		dim as integer cnt = 0
		
		do while cnt = 0
			do while cnt = 0
				cnt += 1
				continue do, do
				cnt += 1
			loop
			cnt += 1
		loop 
		
		CU_ASSERT_EQUAL( cnt, 1 )
	END_TEST

	TEST( test_while )
		dim as integer cnt = 0
		
		while cnt = 0
			while cnt = 0
				cnt += 1
				continue while, while
				cnt += 1
			wend
			cnt += 1
		wend
		
		CU_ASSERT_EQUAL( cnt, 1 )
	END_TEST

END_SUITE
