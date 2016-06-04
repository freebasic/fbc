# include "fbcu.bi"

namespace fbc_tests.string_.lrset

#macro TEST_LSET(s1, s2, l1, l2)
	s1 = left("ABCDEFGH", (l1) )
	s2 = left("01234567", (l2) )
	lset s1 = s2
	if( (l1) >= (l2) ) then
		CU_ASSERT_EQUAL( s1, (s2) & space( (l1) - (l2) ) )
	else
		CU_ASSERT_EQUAL( s1, left( s2, l1 ) )
	end if
#endmacro

#macro TEST_RSET(s1, s2, l1, l2)
	s1 = left("ABCDEFGH", (l1) )
	s2 = left("01234567", (l2) )
	rset (s1) = (s2)
	if( (l1) >= (l2) ) then
		CU_ASSERT_EQUAL( s1, space( (l1) - (l2) ) & (s2) )
	else
		CU_ASSERT_EQUAL( s1, left( s2, l1 ) )
	end if
#endmacro

sub test_lrset cdecl ()

	const MAX = 8
	dim as string s1, s2
	dim as zstring*(MAX+1) z1, z2

	for i1 as integer = 0 to MAX
		for i2 as integer = 0 to MAX

			TEST_LSET( s1, s2, i1, i2 )
			TEST_LSET( s1, z2, i1, i2 )
			TEST_LSET( z1, s2, i1, i2 )
			TEST_LSET( z1, z2, i1, i2 )

			TEST_RSET( s1, s2, i1, i2 )
			TEST_RSET( s1, z2, i1, i2 )
			TEST_RSET( z1, s2, i1, i2 )
			TEST_RSET( z1, z2, i1, i2 )

		next i2
	next i1

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string.lrset")
	fbcu.add_test("test_lrset", @test_lrset)

end sub

end namespace
