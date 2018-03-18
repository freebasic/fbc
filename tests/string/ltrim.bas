#include "fbcunit.bi"

SUITE( fbc_tests.string_.ltrim_ )

	dim shared result as integer
	dim shared str_ret as string

	TEST( test1 )

		str_ret = ltrim("asd", "")
		CU_ASSERT( len(str_ret) = 3 )
		CU_ASSERT( str_ret = "asd" )

		str_ret = ltrim(" asd", "")
		CU_ASSERT( len(str_ret) = 4 )
		CU_ASSERT( str_ret = " asd" )

		str_ret = ltrim("  asd", "")
		CU_ASSERT( len(str_ret) = 5 )
		CU_ASSERT( str_ret = "  asd" )

	END_TEST

	TEST( test2 )

		str_ret = ltrim("asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(" asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("  asd")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test3 )

		str_ret = ltrim("asd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("xasd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("xxasd", "x")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test4 )

		str_ret = ltrim("asd", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("xasd", "xy")
		CU_ASSERT( len(str_ret) = 4 )
		result = str_ret = "xasd"
		CU_ASSERT( result )

		str_ret = ltrim("xyasd", "xy")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("xyasd", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "xyasd"
		CU_ASSERT( result )

		str_ret = ltrim("yyasd", "yx")
		CU_ASSERT( len(str_ret) = 5 )
		result = str_ret = "yyasd"
		CU_ASSERT( result )

	END_TEST

	TEST( test5 )

		str_ret = ltrim("asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim(" asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

		str_ret = ltrim("  asd", any " ")
		CU_ASSERT( len(str_ret) = 3 )
		result = str_ret = "asd"
		CU_ASSERT( result )

	END_TEST

	TEST( test6 )

		str_ret = ltrim("asd", any " a")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim(" asd", any " a")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim("  asd", any " a")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

	END_TEST

	TEST( test7 )

		str_ret = ltrim("asd", any "a ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim(" asd", any "a ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

		str_ret = ltrim("  asd", any "a ")
		CU_ASSERT( len(str_ret) = 2 )
		result = str_ret = "sd"
		CU_ASSERT( result )

	END_TEST

	TEST( test8 )

		str_ret = ltrim("asd", any "")
		CU_ASSERT( len(str_ret) = 3 )
		CU_ASSERT( str_ret = "asd" )

		str_ret = ltrim(" asd", any "")
		CU_ASSERT( len(str_ret) = 4 )
		CU_ASSERT( str_ret = " asd" )

		str_ret = ltrim("  asd", any "")
		CU_ASSERT( len(str_ret) = 5 )
		CU_ASSERT( str_ret = "  asd" )

	END_TEST

END_SUITE
