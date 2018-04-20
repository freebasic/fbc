#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.symb )

	TEST( default )

		dim as wstring ptr w1, w2

		w1 = @wstr("a"): w2 = @wstr("b")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aa"): w2 = @wstr("ab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaa"): w2 = @wstr("aab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaa"): w2 = @wstr("aaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaaa"): w2 = @wstr("aaaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaaaa"): w2 = @wstr("aaaaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaaaaa"): w2 = @wstr("aaaaaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaaaaaa"): w2 = @wstr("aaaaaaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaaaaaaa"): w2 = @wstr("aaaaaaaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaaaaaaaa"): w2 = @wstr("aaaaaaaaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaaaaaaaaa"): w2 = @wstr("aaaaaaaaaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaaaaaaaaaa"): w2 = @wstr("aaaaaaaaaaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

		w1 = @wstr("aaaaaaaaaaaaa"): w2 = @wstr("aaaaaaaaaaaab")
		CU_ASSERT_NOT_EQUAL( w1, w2 )

	END_TEST

END_SUITE
