#include "fbcunit.bi"

SUITE( fbc_tests.wstrings.rtrim_ )

	dim shared result as integer
	dim shared str_ret as wstring*32

	TEST( test1 )

		str_ret = rtrim(wstr("asd"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asd "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asd  "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test2 )

		str_ret = rtrim(wstr("asd"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asdx"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asdxx"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test3 )

		str_ret = rtrim(wstr("asd"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asdx"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 4 )
		result = str_ret = "asdx"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asdxy"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asdxy"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "asdxy"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asdyy"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "asdyy"
		CU_ASSERT( result )

	END_TEST

	TEST( test4 )

		str_ret = rtrim(wstr("asd"), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asd "), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asd  "), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test5 )

		str_ret = rtrim(wstr("asd"), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asd "), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asd  "), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

	END_TEST

	TEST( test6 )

		str_ret = rtrim(wstr("asd"), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asd "), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = rtrim(wstr("asd  "), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

	END_TEST

END_SUITE
