#include "fbcunit.bi"

SUITE( fbc_tests.compound.loop_ )

	TEST( testWhile )
		dim as integer i

		i = 0
		while( i = 0 )
			i += 1
		wend
		CU_ASSERT( i = 1 )

		i = 0
		while( i = 5 )
			i += 1
		wend
		CU_ASSERT( i = 0 )

		i = 0
		while( i <> 5 )
			i += 1
		wend
		CU_ASSERT( i = 5 )

		i = 0
		while( i < 5 )
			i += 1
		wend
		CU_ASSERT( i = 5 )

		i = 0
		while( i <= 5 )
			i += 1
		wend
		CU_ASSERT( i = 6 )

		i = 5
		while( i > 0 )
			i -= 1
		wend
		CU_ASSERT( i = 0 )

		i = 5
		while( i >= 0 )
			i -= 1
		wend
		CU_ASSERT( i = -1 )
	END_TEST

	TEST( testDoWhile )
		dim as integer i

		i = 0
		do while( i = 0 )
			i += 1
		loop
		CU_ASSERT( i = 1 )

		i = 0
		do while( i = 5 )
			i += 1
		loop
		CU_ASSERT( i = 0 )

		i = 0
		do while( i <> 5 )
			i += 1
		loop
		CU_ASSERT( i = 5 )

		i = 0
		do while( i < 5 )
			i += 1
		loop
		CU_ASSERT( i = 5 )

		i = 0
		do while( i <= 5 )
			i += 1
		loop
		CU_ASSERT( i = 6 )

		i = 5
		do while( i > 0 )
			i -= 1
		loop
		CU_ASSERT( i = 0 )

		i = 5
		do while( i >= 0 )
			i -= 1
		loop
		CU_ASSERT( i = -1 )
	END_TEST

	TEST( testLoopWhile )
		dim as integer i

		i = 0
		do
			i += 1
		loop while( i = 0 )
		CU_ASSERT( i = 1 )

		i = 0
		do
			i += 1
		loop while( i = 5 )
		CU_ASSERT( i = 1 )

		i = 0
		do
			i += 1
		loop while( i <> 5 )
		CU_ASSERT( i = 5 )

		i = 0
		do
			i += 1
		loop while( i < 5 )
		CU_ASSERT( i = 5 )

		i = 0
		do
			i += 1
		loop while( i <= 5 )
		CU_ASSERT( i = 6 )

		i = 5
		do
			i -= 1
		loop while( i > 0 )
		CU_ASSERT( i = 0 )

		i = 5
		do
			i -= 1
		loop while( i >= 0 )
		CU_ASSERT( i = -1 )
	END_TEST

	TEST( testDoUntil )
		dim as integer i

		i = 0
		do until( i = 0 )
			i += 1
		loop
		CU_ASSERT( i = 0 )

		i = 0
		do until( i = 5 )
			i += 1
		loop
		CU_ASSERT( i = 5 )

		i = 5
		do until( i <> 5 )
			i -= 1
		loop
		CU_ASSERT( i = 4 )

		i = 5
		do until( i < 5 )
			i -= 1
		loop
		CU_ASSERT( i = 4 )

		i = 5
		do until( i <= 5 )
			i -= 1
		loop
		CU_ASSERT( i = 5 )

		i = 0
		do until( i > 0 )
			i += 1
		loop
		CU_ASSERT( i = 1 )

		i = 0
		do until( i >= 0 )
			i += 1
		loop
		CU_ASSERT( i = 0 )
	END_TEST

	TEST( testLoopUntil )
		dim as integer i

		i = 0
		do
			i += 1
		loop until( i = 1 )
		CU_ASSERT( i = 1 )

		i = 0
		do
			i += 1
		loop until( i = 5 )
		CU_ASSERT( i = 5 )

		i = 5
		do
			i -= 1
		loop until( i <> 5 )
		CU_ASSERT( i = 4 )

		i = 5
		do
			i -= 1
		loop until( i < 5 )
		CU_ASSERT( i = 4 )

		i = 5
		do
			i -= 1
		loop until( i <= 5 )
		CU_ASSERT( i = 4 )

		i = 0
		do
			i += 1
		loop until( i > 0 )
		CU_ASSERT( i = 1 )

		i = 0
		do
			i += 1
		loop until( i >= 0 )
		CU_ASSERT( i = 1 )
	END_TEST

	TEST( testContinueWhile )
		dim as string s = ""
		dim as integer i = 0

		while i < 10
			if i = 5 then
				s = str(i)
				i += 1
				continue while
			end if
			i += 1
		wend

		CU_ASSERT_EQUAL( s, "5" )
	END_TEST

END_SUITE
