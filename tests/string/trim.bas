# include "fbcu.bi"




namespace fbc_tests.string_.trim_

 

dim shared result as integer
dim shared str_ret as string

sub trimDefaultCharTest cdecl ()

	str_ret = trim("asd", "")
	CU_ASSERT( len(str_ret) = 3 )
	CU_ASSERT( str_ret = "asd" )

	str_ret = trim("asd")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("asd ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("asd  ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim(" asd")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("  asd")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim(" asd ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("  asd  ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

end sub

sub trimCharTest cdecl ()

	str_ret = trim("asd", "x")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("asdx", "x")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("asdxx", "x")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("xasd", "x")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("xxasd", "x")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("xasdx", "x")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("xxasdxx", "x")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

end sub

sub trimStringTest cdecl ()

	str_ret = trim("asd", "xy")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("asdx", "xy")
	CU_ASSERT( len(str_ret) = 4 )
	result = str_ret = "asdx"
	CU_ASSERT( result )

	str_ret = trim("asdxy", "xy")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("asdxy", "yx")
	CU_ASSERT( len(str_ret) = 5 )
	result = str_ret = "asdxy"
	CU_ASSERT( result )

	str_ret = trim("asdyy", "yx")
	CU_ASSERT( len(str_ret) = 5 )
	result = str_ret = "asdyy"
	CU_ASSERT( result )

	str_ret = trim("xasd", "xy")
	CU_ASSERT( len(str_ret) = 4 )
	result = str_ret = "xasd"
	CU_ASSERT( result )

	str_ret = trim("xyasd", "xy")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("xyasd", "yx")
	CU_ASSERT( len(str_ret) = 5 )
	result = str_ret = "xyasd"
	CU_ASSERT( result )

	str_ret = trim("yyasd", "yx")
	CU_ASSERT( len(str_ret) = 5 )
	result = str_ret = "yyasd"
	CU_ASSERT( result )

	str_ret = trim("xasdx", "xy")
	CU_ASSERT( len(str_ret) = 5 )
	result = str_ret = "xasdx"
	CU_ASSERT( result )

	str_ret = trim("xyasdxy", "xy")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("xyasdxy", "yx")
	CU_ASSERT( len(str_ret) = 7 )
	result = str_ret = "xyasdxy"
	CU_ASSERT( result )

	str_ret = trim("yyasdyy", "yx")
	CU_ASSERT( len(str_ret) = 7 )
	result = str_ret = "yyasdyy"
	CU_ASSERT( result )

end sub

sub trimAnyCharTest cdecl ()

	str_ret = trim("asd", any "")
	CU_ASSERT( len(str_ret) = 3 )
	CU_ASSERT( str_ret = "asd" )

	str_ret = trim("asd", any " ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("asd ", any " ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("asd  ", any " ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim(" asd", any " ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("  asd", any " ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim(" asd ", any " ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

	str_ret = trim("  asd  ", any " ")
	CU_ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	CU_ASSERT( result )

end sub

sub trimAnyStringTest cdecl ()

	str_ret = trim("asd", any " d")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("asd ", any " d")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("asd  ", any " d")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("das", any " d")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim(" das", any " d")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("  das", any " d")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("dasd", any " d")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim(" dasd ", any " d")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("  dasd  ", any " d")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

end sub

sub trimAnyStringInvertedTest cdecl ()

	str_ret = trim("asd", any "d ")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("asd ", any "d ")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("asd  ", any "d ")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("das", any "d ")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim(" das", any "d ")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("  das", any "d ")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("dasd", any "d ")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim(" dasd ", any "d ")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

	str_ret = trim("  dasd  ", any "d ")
	CU_ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	CU_ASSERT( result )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string.trim")
	fbcu.add_test("trimDefaultCharTest", @trimDefaultCharTest)
	fbcu.add_test("trimCharTest", @trimCharTest)
	fbcu.add_test("trimStringTest", @trimStringTest)
	fbcu.add_test("trimAnyCharTest", @trimAnyCharTest)
	fbcu.add_test("trimAnyStringTest", @trimAnyStringTest)
	fbcu.add_test("trimAnyStringInvertedTest", @trimAnyStringInvertedTest)

end sub

end namespace
