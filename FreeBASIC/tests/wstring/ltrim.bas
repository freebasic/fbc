

dim result as integer
dim str_ret as wstring*32



str_ret = ltrim(wstr("asd"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = ltrim(wstr(" asd"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = ltrim(wstr("  asd"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = ltrim(wstr("asd"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = ltrim(wstr("xasd"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = ltrim(wstr("xxasd"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = ltrim(wstr("asd"), wstr("xy"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = ltrim(wstr("xasd"), wstr("xy"))
ASSERT( len(str_ret) = 4 )
result = str_ret = "xasd"
ASSERT( result )

str_ret = ltrim(wstr("xyasd"), wstr("xy"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = ltrim(wstr("xyasd"), wstr("yx"))
ASSERT( len(str_ret) = 5 )
result = str_ret = "xyasd"
ASSERT( result )

str_ret = ltrim(wstr("yyasd"), wstr("yx"))
ASSERT( len(str_ret) = 5 )
result = str_ret = "yyasd"
ASSERT( result )



str_ret = ltrim(wstr("asd"), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = ltrim(wstr(" asd"), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = ltrim(wstr("  asd"), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = ltrim(wstr("asd"), any wstr(" a"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "sd"
ASSERT( result )

str_ret = ltrim(wstr(" asd"), any wstr(" a"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "sd"
ASSERT( result )

str_ret = ltrim(wstr("  asd"), any wstr(" a"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "sd"
ASSERT( result )



str_ret = ltrim(wstr("asd"), any wstr("a "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "sd"
ASSERT( result )

str_ret = ltrim(wstr(" asd"), any wstr("a "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "sd"
ASSERT( result )

str_ret = ltrim(wstr("  asd"), any wstr("a "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "sd"
ASSERT( result )
