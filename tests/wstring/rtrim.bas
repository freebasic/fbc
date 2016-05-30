# include "fbcu.bi"




namespace fbc_tests.wstrings.rtrim_

 

dim shared result as integer
dim shared str_ret as wstring*32

sub test_1 cdecl ()

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

end sub

sub test_2 cdecl ()

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

end sub

sub test_3 cdecl ()

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

end sub

sub test_4 cdecl ()

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

end sub

sub test_5 cdecl ()

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

end sub

sub test_6 cdecl ()

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

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.wstring.rtrim")
	fbcu.add_test("test_1", @test_1)
	fbcu.add_test("test_2", @test_2)
	fbcu.add_test("test_3", @test_3)
	fbcu.add_test("test_4", @test_4)
	fbcu.add_test("test_5", @test_5)
	fbcu.add_test("test_6", @test_6)

end sub

end namespace
