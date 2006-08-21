# include "fbcu.bi"

namespace fbc_tests.string_.rtrim_

dim shared result as integer
dim shared str_ret as string

sub test_1 cdecl ()

	str_ret = rtrim("asd")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = rtrim("asd ")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = rtrim("asd  ")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

end sub



sub test_2 cdecl ()

	str_ret = rtrim("asd", "x")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = rtrim("asdx", "x")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = rtrim("asdxx", "x")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

end sub



sub test_3 cdecl ()

	str_ret = rtrim("asd", "xy")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = rtrim("asdx", "xy")
	ASSERT( len(str_ret) = 4 )
	result = str_ret = "asdx"
	ASSERT( result )

	str_ret = rtrim("asdxy", "xy")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = rtrim("asdxy", "yx")
	ASSERT( len(str_ret) = 5 )
	result = str_ret = "asdxy"
	ASSERT( result )

	str_ret = rtrim("asdyy", "yx")
	ASSERT( len(str_ret) = 5 )
	result = str_ret = "asdyy"
	ASSERT( result )

end sub



sub test_4 cdecl ()

	str_ret = rtrim("asd", any " ")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = rtrim("asd ", any " ")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

	str_ret = rtrim("asd  ", any " ")
	ASSERT( len(str_ret) = 3 )
	result = str_ret = "asd"
	ASSERT( result )

end sub



sub test_5 cdecl ()

	str_ret = rtrim("asd", any " d")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	ASSERT( result )

	str_ret = rtrim("asd ", any " d")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	ASSERT( result )

	str_ret = rtrim("asd  ", any " d")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	ASSERT( result )

end sub



sub test_6 cdecl ()

	str_ret = rtrim("asd", any "d ")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	ASSERT( result )

	str_ret = rtrim("asd ", any "d ")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	ASSERT( result )

	str_ret = rtrim("asd  ", any "d ")
	ASSERT( len(str_ret) = 2 )
	result = str_ret = "as"
	ASSERT( result )

end sub

sub ctor () constructor

	fbcu.add_suite("fbc_tests.string_.rtrim_")
	fbcu.add_test("number format test", @test_1)
	fbcu.add_test("number format test", @test_2)
	fbcu.add_test("number format test", @test_3)
	fbcu.add_test("number format test", @test_4)
	fbcu.add_test("number format test", @test_5)
	fbcu.add_test("number format test", @test_6)

end sub

end namespace
