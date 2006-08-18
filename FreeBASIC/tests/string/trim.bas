

dim result as integer
dim str_ret as string

str_ret = trim("asd")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("asd ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("asd  ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(" asd")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("  asd")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(" asd ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("  asd  ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = trim("asd", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("asdx", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("asdxx", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("xasd", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("xxasd", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("xasdx", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("xxasdxx", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = trim("asd", "xy")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("asdx", "xy")
ASSERT( len(str_ret) = 4 )
result = str_ret = "asdx"
ASSERT( result )

str_ret = trim("asdxy", "xy")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("asdxy", "yx")
ASSERT( len(str_ret) = 5 )
result = str_ret = "asdxy"
ASSERT( result )

str_ret = trim("asdyy", "yx")
ASSERT( len(str_ret) = 5 )
result = str_ret = "asdyy"
ASSERT( result )

str_ret = trim("xasd", "xy")
ASSERT( len(str_ret) = 4 )
result = str_ret = "xasd"
ASSERT( result )

str_ret = trim("xyasd", "xy")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("xyasd", "yx")
ASSERT( len(str_ret) = 5 )
result = str_ret = "xyasd"
ASSERT( result )

str_ret = trim("yyasd", "yx")
ASSERT( len(str_ret) = 5 )
result = str_ret = "yyasd"
ASSERT( result )

str_ret = trim("xasdx", "xy")
ASSERT( len(str_ret) = 5 )
result = str_ret = "xasdx"
ASSERT( result )

str_ret = trim("xyasdxy", "xy")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("xyasdxy", "yx")
ASSERT( len(str_ret) = 7 )
result = str_ret = "xyasdxy"
ASSERT( result )

str_ret = trim("yyasdyy", "yx")
ASSERT( len(str_ret) = 7 )
result = str_ret = "yyasdyy"
ASSERT( result )



str_ret = trim("asd", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("asd ", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("asd  ", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(" asd", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("  asd", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim(" asd ", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = trim("  asd  ", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = trim("asd", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("asd ", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("asd  ", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("das", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(" das", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("  das", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("dasd", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(" dasd ", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("  dasd  ", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )



str_ret = trim("asd", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("asd ", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("asd  ", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("das", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(" das", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("  das", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("dasd", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim(" dasd ", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = trim("  dasd  ", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )


