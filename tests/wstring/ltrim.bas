# include "fbcu.bi"




namespace fbc_tests.wstrings.ltrim_

 

dim shared result as integer
dim shared str_ret as wstring*32

sub test_1 cdecl ()

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

end sub

sub test_2 cdecl ()

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

end sub


sub test_3 cdecl ()

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

end sub


sub test_4 cdecl ()

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

end sub


sub test_5 cdecl ()

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

end sub


sub test_6 cdecl ()

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

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstring.ltrim")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)
	fbcu.add_test("test_3", @test_3)
	fbcu.add_test("test_4", @test_4)
	fbcu.add_test("test_5", @test_5)
	fbcu.add_test("test_6", @test_6)

end sub

end namespace
