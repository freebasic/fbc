

dim result as integer
dim str_ret as string

str_ret = trim(wstr("asd"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("asd "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("asd  "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr(" asd"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("  asd"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr(" asd "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("  asd  "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = trim(wstr("asd"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("asdx"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("asdxx"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("xasd"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("xxasd"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("xasdx"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("xxasdxx"), wstr("x"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = trim(wstr("asd"), wstr("xy"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("asdx"), wstr("xy"))
ASSERT( len(str_ret) = 4 )
result = str_ret = "asdx"
ASSERT( result )

str_ret = trim(wstr("asdxy"), wstr("xy"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("asdxy"), wstr("yx"))
ASSERT( len(str_ret) = 5 )
result = str_ret = "asdxy"
ASSERT( result )

str_ret = trim(wstr("asdyy"), wstr("yx"))
ASSERT( len(str_ret) = 5 )
result = str_ret = "asdyy"
ASSERT( result )

str_ret = trim(wstr("xasd"), wstr("xy"))
ASSERT( len(str_ret) = 4 )
result = str_ret = "xasd"
ASSERT( result )

str_ret = trim(wstr("xyasd"), wstr("xy"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("xyasd"), wstr("yx"))
ASSERT( len(str_ret) = 5 )
result = str_ret = "xyasd"
ASSERT( result )

str_ret = trim(wstr("yyasd"), wstr("yx"))
ASSERT( len(str_ret) = 5 )
result = str_ret = "yyasd"
ASSERT( result )

str_ret = trim(wstr("xasdx"), wstr("xy"))
ASSERT( len(str_ret) = 5 )
result = str_ret = "xasdx"
ASSERT( result )

str_ret = trim(wstr("xyasdxy"), wstr("xy"))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("xyasdxy"), wstr("yx"))
ASSERT( len(str_ret) = 7 )
result = str_ret = "xyasdxy"
ASSERT( result )

str_ret = trim(wstr("yyasdyy"), wstr("yx"))
ASSERT( len(str_ret) = 7 )
result = str_ret = "yyasdyy"
ASSERT( result )



str_ret = trim(wstr("asd"), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("asd "), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("asd  "), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr(" asd"), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("  asd"), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr(" asd "), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(wstr("  asd  "), any wstr(" "))
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = trim(wstr("asd"), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("asd "), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("asd  "), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("das"), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr(" das"), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("  das"), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("dasd"), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr(" dasd "), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("  dasd  "), any wstr(" d"))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )



str_ret = trim(wstr("asd"), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("asd "), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("asd  "), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("das"), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr(" das"), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("  das"), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("dasd"), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr(" dasd "), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(wstr("  dasd  "), any wstr("d "))
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )


