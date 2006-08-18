

dim result as integer
dim str_ret as string



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
