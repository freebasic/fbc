option explicit

defint a-z

dim result as integer
dim str_ret as wstring*32

str_ret = rtrim$(wstr("asd"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$(wstr("asd "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$(wstr("asd  "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = rtrim$(wstr("asd"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$(wstr("asdx"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$(wstr("asdxx"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = rtrim$(wstr("asd"), wstr("xy"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$(wstr("asdx"), wstr("xy"))
ASSERT( len(str_ret) = 4 )
result = str_ret = "asdx"
ASSERT( result )

str_ret = rtrim$(wstr("asdxy"), wstr("xy"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$(wstr("asdxy"), wstr("yx"))
ASSERT( len(str_ret) = 5 )
result = str_ret = "asdxy"
ASSERT( result )

str_ret = rtrim$(wstr("asdyy"), wstr("yx"))
ASSERT( len(str_ret) = 5 )
result = str_ret = "asdyy"
ASSERT( result )



str_ret = rtrim$(wstr("asd"), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$(wstr("asd "), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$(wstr("asd  "), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = rtrim$(wstr("asd"), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = rtrim$(wstr("asd "), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = rtrim$(wstr("asd  "), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )



str_ret = rtrim$(wstr("asd"), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = rtrim$(wstr("asd "), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = rtrim$(wstr("asd  "), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )
