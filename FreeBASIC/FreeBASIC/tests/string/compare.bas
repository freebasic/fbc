# include "fbcu.bi"




namespace fbc_tests.string_.compare

dim shared as string s1, s2

sub equalSizeTest cdecl ()

	s1 = "a"
	s2 = "b"

	CU_ASSERT( s1<>s2 )
	CU_ASSERT( s1<s2 )

	s1 = "b"
	s2 = "a"

	CU_ASSERT( s1<>s2 )
	CU_ASSERT( s1>s2 )

end sub

sub equalTest cdecl ()

	s1 = "a"
	s2 = "a"

	CU_ASSERT( s1=s2 )

end sub

sub unequalSizeTest cdecl ()

	s1 = "a"
	s2 = "ab"

	CU_ASSERT( s1<>s2 )
	CU_ASSERT( s1<s2 )

	s1 = "ab"
	s2 = "a"

	CU_ASSERT( s1<>s2 )
	CU_ASSERT( s1>s2 )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.compare")
	fbcu.add_test("equalSizeTest", @equalSizeTest)
	fbcu.add_test("equalTest", @equalTest)
	fbcu.add_test("unequalSizeTest", @unequalSizeTest)

end sub

end namespace
