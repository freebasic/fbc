#include "fbcunit.bi"

SUITE( fbc_tests.string_.lrset )

	#macro TEST_LSET(s1, n1, s2, n2, l1, l2)
		s1 = left("ABCDEFGH", (l1) )
		s2 = left("01234567", (l2) )
		lset s1 = s2
		if( n1 > 0 ) then
			if( n2 > 0 ) then
				CU_ASSERT_EQUAL( s1, s2 )
			else
				CU_ASSERT_EQUAL( s1, (s2) & space( (n1) - (l2) ) )
			end if
		else
			if( n2 > 0 ) then
				CU_ASSERT_EQUAL( s1, left( s2, l1 ) )
			else
				if( (l1) >= (l2) ) then
					CU_ASSERT_EQUAL( s1, (s2) & space( (l1) - (l2) ) )
				else
					CU_ASSERT_EQUAL( s1, left( s2, l1 ) )
				end if
			end if
		end if
	#endmacro

	#macro TEST_RSET(s1, n1, s2, n2, l1, l2)
		s1 = left("ABCDEFGH", (l1) )
		s2 = left("01234567", (l2) )
		rset (s1) = (s2)
		if( n1 > 0 ) then
			if( n2 > 0 ) then
				CU_ASSERT_EQUAL( s1, s2 )
			else
				CU_ASSERT_EQUAL( s1, space( (n1) - (l2) ) & (s2) )
			end if
		else
			if( n2 > 0 ) then
				CU_ASSERT_EQUAL( s1, left( s2, l1 ) )
			else
				if( (l1) >= (l2) ) then
					CU_ASSERT_EQUAL( s1, space( (l1) - (l2) ) & (s2) )
				else
					CU_ASSERT_EQUAL( s1, left( s2, l1 ) )
				end if
			end if
		end if
	#endmacro

	TEST( all )

		const MAX = 8
		dim as string s1, s2
		dim as zstring*(MAX+1) z1, z2
		dim as string*MAX f1, f2

		for i1 as integer = 0 to MAX
			for i2 as integer = 0 to MAX

				TEST_LSET( s1, 0         , s2, 0         , i1, i2 )
				TEST_LSET( s1, 0         , z2, 0         , i1, i2 )
				TEST_LSET( s1, 0         , f2, sizeof(f2), i1, i2 )
				TEST_LSET( z1, 0         , s2, 0         , i1, i2 )
				TEST_LSET( z1, 0         , z2, 0         , i1, i2 )
				TEST_LSET( z1, 0         , f2, sizeof(f2), i1, i2 )
				TEST_LSET( f1, sizeof(f1), s2, 0         , i1, i2 )
				TEST_LSET( f1, sizeof(f1), z2, 0         , i1, i2 )
				TEST_LSET( f1, sizeof(f1), f2, sizeof(f2), i1, i2 )

				TEST_RSET( s1, 0         , s2, 0         , i1, i2 )
				TEST_RSET( s1, 0         , z2, 0         , i1, i2 )
				TEST_RSET( s1, 0         , f2, sizeof(f2), i1, i2 )
				TEST_RSET( z1, 0         , s2, 0         , i1, i2 )
				TEST_RSET( z1, 0         , z2, 0         , i1, i2 )
				TEST_RSET( z1, 0         , f2, sizeof(f2), i1, i2 )
				TEST_RSET( f1, sizeof(f1), s2, 0         , i1, i2 )
				TEST_RSET( f1, sizeof(f1), z2, 0         , i1, i2 )
				TEST_RSET( f1, sizeof(f1), f2, sizeof(f2), i1, i2 )

			next i2
		next i1

	END_TEST

END_SUITE
