# include "fbcu.bi"

namespace fbc_tests.overloads.hex_oct_bin

sub test_hex_to_string (b as byte, s as short, i as integer, l as longint, p as any ptr)
	CU_ASSERT_EQUAL( hex( b ), "80" )
	CU_ASSERT_EQUAL( hex( s ), "8000" )
	CU_ASSERT_EQUAL( hex( i ), "80000000" )
	CU_ASSERT_EQUAL( hex( p ), "80000000" )
	CU_ASSERT_EQUAL( hex( l ), "8000000000000000" )
end sub

sub test_oct_to_string (b as byte, s as short, i as integer, l as longint, p as any ptr)
	CU_ASSERT_EQUAL( oct( b ), "200" )
	CU_ASSERT_EQUAL( oct( s ), "100000" )
	CU_ASSERT_EQUAL( oct( i ), "20000000000" )
	CU_ASSERT_EQUAL( oct( p ), "20000000000" )
	CU_ASSERT_EQUAL( oct( l ), "1000000000000000000000" )
end sub

sub test_bin_to_string (b as byte, s as short, i as integer, l as longint, p as any ptr)
	CU_ASSERT_EQUAL( bin( b ), "10000000" )
	CU_ASSERT_EQUAL( bin( s ), "1000000000000000" )
	CU_ASSERT_EQUAL( bin( i ), "10000000000000000000000000000000" )
	CU_ASSERT_EQUAL( bin( p ), "10000000000000000000000000000000" )
	CU_ASSERT_EQUAL( bin( l ), "1000000000000000000000000000000000000000000000000000000000000000" )
end sub

sub test_conversions cdecl ()
	dim b as byte = -2 ^ 7
	dim s as short = -2 ^ 15
	dim i as integer = -2 ^ 31
	dim l as longint = -2LL ^ 63
	dim p as any ptr = cptr(any ptr, i)

	test_hex_to_string(b, s, i, l, p)
	test_oct_to_string(b, s, i, l, p)
	test_bin_to_string(b, s, i, l, p)

end sub

private sub ctor () constructor

	fbcu.add_suite("fb-tests-overload:numerical base conversions to string")
	fbcu.add_test("test_conversions", @test_conversions)

end sub

end namespace
