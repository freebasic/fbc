#include "fbcunit.bi"

SUITE( fbc_tests.wstring_.ltrim_ )

	dim shared result as integer
	dim shared str_ret as wstring*32

	TEST( test1 )

		str_ret = ltrim(wstr("asd"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr(" asd"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("  asd"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test2 )

		str_ret = ltrim(wstr("asd"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("xasd"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("xxasd"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test3 )

		str_ret = ltrim(wstr("asd"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("xasd"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 4 )
		result = str_ret = "xasd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("xyasd"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("xyasd"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "xyasd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("yyasd"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "yyasd"
		CU_ASSERT( result )

	END_TEST

	TEST( test4 )

		str_ret = ltrim(wstr("asd"), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr(" asd"), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("  asd"), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test5 )

		str_ret = ltrim(wstr("asd"), any wstr(" a"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr(" asd"), any wstr(" a"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("  asd"), any wstr(" a"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

	END_TEST

	TEST( test6 )

		str_ret = ltrim(wstr("asd"), any wstr("a "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr(" asd"), any wstr("a "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim(wstr("  asd"), any wstr("a "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

	END_TEST

END_SUITE
