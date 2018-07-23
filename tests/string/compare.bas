#include "fbcunit.bi"

SUITE( fbc_tests.string_.compare )

	dim shared as string s1, s2

	TEST( equalSizeTest )

		s1 = "a"
		s2 = "b"

		CU_ASSERT( s1<>s2 )
		CU_ASSERT( s1<s2 )

		s1 = "b"
		s2 = "a"

		CU_ASSERT( s1<>s2 )
		CU_ASSERT( s1>s2 )

	END_TEST

	TEST( equalTest )

		s1 = "a"
		s2 = "a"

		CU_ASSERT( s1=s2 )

	END_TEST

	TEST( unequalSizeTest )

		s1 = "a"
		s2 = "ab"

		CU_ASSERT( s1<>s2 )
		CU_ASSERT( s1<s2 )

		s1 = "ab"
		s2 = "a"

		CU_ASSERT( s1<>s2 )
		CU_ASSERT( s1>s2 )

	END_TEST

END_SUITE
