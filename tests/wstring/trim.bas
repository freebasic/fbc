# include "fbcu.bi"




namespace fbc_tests.wstrings.trim_

 

dim shared result as integer
dim shared str_ret as string

sub test_1 cdecl ()

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

end sub

sub test_2 cdecl ()

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

end sub


sub test_3 cdecl ()

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

end sub


sub test_4 cdecl ()

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

end sub


sub test_5 cdecl ()

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

end sub


sub test_6 cdecl ()

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

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstring.trim")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)
	fbcu.add_test("test_3", @test_3)
	fbcu.add_test("test_4", @test_4)
	fbcu.add_test("test_5", @test_5)
	fbcu.add_test("test_6", @test_6)

end sub

end namespace
