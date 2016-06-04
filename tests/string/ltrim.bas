# include "fbcu.bi"

namespace fbc_tests.string_.ltrim_

dim shared result as integer
dim shared str_ret as string


sub test_0 cdecl ()

	str_ret = ltrim("asd", "")
	CU_ASSERT( len(str_ret) = 3 )
	CU_ASSERT( str_ret = "asd" )

	str_ret = ltrim(" asd", "")
	CU_ASSERT( len(str_ret) = 4 )
	CU_ASSERT( str_ret = " asd" )

	str_ret = ltrim("  asd", "")
	CU_ASSERT( len(str_ret) = 5 )
	CU_ASSERT( str_ret = "  asd" )

end sub

sub test_1 cdecl ()

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

end sub


sub test_2 cdecl ()

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

end sub


sub test_3 cdecl ()

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

end sub


sub test_4 cdecl ()

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

end sub


sub test_5 cdecl ()

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

end sub


sub test_6 cdecl ()

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

end sub

sub test_7 cdecl ()

	str_ret = ltrim("asd", any "")
	CU_ASSERT( len(str_ret) = 3 )
	CU_ASSERT( str_ret = "asd" )

	str_ret = ltrim(" asd", any "")
	CU_ASSERT( len(str_ret) = 4 )
	CU_ASSERT( str_ret = " asd" )

	str_ret = ltrim("  asd", any "")
	CU_ASSERT( len(str_ret) = 5 )
	CU_ASSERT( str_ret = "  asd" )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string.ltrim")
	fbcu.add_test("#0", @test_0)
	fbcu.add_test("#1", @test_1)
	fbcu.add_test("#2", @test_2)
	fbcu.add_test("#3", @test_3)
	fbcu.add_test("#4", @test_4)
	fbcu.add_test("#5", @test_5)
	fbcu.add_test("#6", @test_6)
	fbcu.add_test("#7", @test_7)

end sub

end namespace
