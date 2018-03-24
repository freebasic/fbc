#include "fbcunit.bi"

SUITE( fbc_tests.wstrings.trim_ )

	dim shared result as integer
	dim shared str_ret as string

	TEST( test1 )

		str_ret = trim(wstr("asd"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("asd "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("asd  "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr(" asd"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("  asd"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr(" asd "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("  asd  "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test2 )

		str_ret = trim(wstr("asd"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("asdx"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("asdxx"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("xasd"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("xxasd"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("xasdx"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("xxasdxx"), wstr("x"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test3 )

		str_ret = trim(wstr("asd"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("asdx"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 4 )
		result = str_ret = "asdx"
		CU_ASSERT( result )

		str_ret = trim(wstr("asdxy"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("asdxy"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "asdxy"
		CU_ASSERT( result )

		str_ret = trim(wstr("asdyy"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "asdyy"
		CU_ASSERT( result )

		str_ret = trim(wstr("xasd"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 4 )
		result = str_ret = "xasd"
		CU_ASSERT( result )

		str_ret = trim(wstr("xyasd"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("xyasd"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "xyasd"
		CU_ASSERT( result )

		str_ret = trim(wstr("yyasd"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "yyasd"
		CU_ASSERT( result )

		str_ret = trim(wstr("xasdx"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "xasdx"
		CU_ASSERT( result )

		str_ret = trim(wstr("xyasdxy"), wstr("xy"))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("xyasdxy"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 7 )
		result = str_ret = "xyasdxy"
		CU_ASSERT( result )

		str_ret = trim(wstr("yyasdyy"), wstr("yx"))
		CU_ASSERT( len(str_ret) = 7 )
		result = str_ret = "yyasdyy"
		CU_ASSERT( result )

	END_TEST

	TEST( test4 )

		str_ret = trim(wstr("asd"), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("asd "), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("asd  "), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr(" asd"), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("  asd"), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr(" asd "), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = trim(wstr("  asd  "), any wstr(" "))
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test5 )

		str_ret = trim(wstr("asd"), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("asd "), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("asd  "), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("das"), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr(" das"), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("  das"), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("dasd"), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr(" dasd "), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("  dasd  "), any wstr(" d"))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

	END_TEST

	TEST( test6 )

		str_ret = trim(wstr("asd"), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("asd "), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("asd  "), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("das"), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr(" das"), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("  das"), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("dasd"), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr(" dasd "), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

		str_ret = trim(wstr("  dasd  "), any wstr("d "))
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "as"
		CU_ASSERT( result )

	END_TEST

END_SUITE
