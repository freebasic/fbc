# include "fbcunit.bi"

SUITE( fbc_tests.compound.if_ )

	TEST( test_multiline_scope )

		dim as integer a = 1, b = 2

		if 0 then
			dim as integer a = 3
			b = a
		elseif 1 then
			dim as integer a = 4
			b = a
		else
			dim as integer a = 5
			b = a
		end if

		CU_ASSERT_EQUAL( a, 1 )
		CU_ASSERT_EQUAL( b, 4 )

	END_TEST

	TEST( test_singleline_scope )

		dim as integer a = 1, b = 2

		if 0 then _
			dim as integer a = 3: _
			b = a _
		else if 1 then _
			dim as integer a = 4: _
			b = a _
		else _
			dim as integer a = 5: _
			b = a

		CU_ASSERT_EQUAL( a, 1 )
		CU_ASSERT_EQUAL( b, 4 )

	END_TEST

END_SUITE
