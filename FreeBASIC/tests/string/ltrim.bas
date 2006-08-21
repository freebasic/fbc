# include "fbcu.bi"

namespace fbc_tests.string_.ltrim_

dim shared result as integer
dim shared str_ret as string


sub test_1 cdecl ()

	str_ret = ltrim("asd")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = ltrim(" asd")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = ltrim("  asd")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

end sub


sub test_2 cdecl ()

	str_ret = ltrim("asd", "x")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = ltrim("xasd", "x")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = ltrim("xxasd", "x")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

end sub


sub test_3 cdecl ()

	str_ret = ltrim("asd", "xy")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = ltrim("xasd", "xy")
	ASSERT( len(str_ret) = 4 )
	result = str_ret = "xasd"
	ASSERT( result )

	str_ret = ltrim("xyasd", "xy")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = ltrim("xyasd", "yx")
	ASSERT( len(str_ret) = 5 )
	result = str_ret = "xyasd"
	ASSERT( result )

	str_ret = ltrim("yyasd", "yx")
	ASSERT( len(str_ret) = 5 )
	result = str_ret = "yyasd"
	ASSERT( result )

end sub


sub test_4 cdecl ()

	str_ret = ltrim("asd", any " ")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = ltrim(" asd", any " ")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = ltrim("  asd", any " ")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

end sub


sub test_5 cdecl ()

	str_ret = ltrim("asd", any " a")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "sd"
	ASSERT( result )

	str_ret = ltrim(" asd", any " a")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "sd"
	ASSERT( result )

	str_ret = ltrim("  asd", any " a")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "sd"
	ASSERT( result )

end sub


sub test_6 cdecl ()

	str_ret = ltrim("asd", any "a ")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "sd"
	ASSERT( result )

	str_ret = ltrim(" asd", any "a ")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "sd"
	ASSERT( result )

	str_ret = ltrim("  asd", any "a ")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "sd"
	ASSERT( result )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.ltrim_")
	fbcu.add_test("number format test", @test_1)
	fbcu.add_test("number format test", @test_2)
	fbcu.add_test("number format test", @test_3)
	fbcu.add_test("number format test", @test_4)
	fbcu.add_test("number format test", @test_5)
	fbcu.add_test("number format test", @test_6)

end sub

end namespace
