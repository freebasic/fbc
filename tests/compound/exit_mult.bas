# include "fbcunit.bi"

SUITE( fbc_tests.compound.exit_mult )

	TEST( test_for )
		dim as integer cnt = 0
		
		for i as integer = 1 to 2
			for j as integer = 1 to 2
				cnt += 1
				exit for, for
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
				exit do, do
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
				exit while, while
				cnt += 1
			wend
			cnt += 1
		wend
		
		CU_ASSERT_EQUAL( cnt, 1 )
	END_TEST

	TEST( test_select )
		dim as integer cnt = 0
		
		select case cnt
		case 0
			select case cnt
			case 0
				cnt += 1
				exit select, select
				cnt += 1
			end select
		end select
		
		CU_ASSERT_EQUAL( cnt, 1 )
	END_TEST

END_SUITE
