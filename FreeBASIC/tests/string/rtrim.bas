option explicit

defint a-z

dim result as integer
dim str_ret as string

str_ret = rtrim$("asd")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$("asd ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$("asd  ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = rtrim$("asd", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$("asdx", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$("asdxx", "x")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = rtrim$("asd", "xy")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$("asdx", "xy")
ASSERT( len(str_ret) = 4 )
result = str_ret = "asdx"
ASSERT( result )

str_ret = rtrim$("asdxy", "xy")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$("asdxy", "yx")
ASSERT( len(str_ret) = 5 )
result = str_ret = "asdxy"
ASSERT( result )

str_ret = rtrim$("asdyy", "yx")
ASSERT( len(str_ret) = 5 )
result = str_ret = "asdyy"
ASSERT( result )



str_ret = rtrim$("asd", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$("asd ", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )

str_ret = rtrim$("asd  ", any " ")
ASSERT( len(str_ret) = 3 )
result = str_ret = "asd"
ASSERT( result )



str_ret = rtrim$("asd", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = rtrim$("asd ", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = rtrim$("asd  ", any " d")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )



str_ret = rtrim$("asd", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = rtrim$("asd ", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )

str_ret = rtrim$("asd  ", any "d ")
ASSERT( len(str_ret) = 2 )
result = str_ret = "as"
ASSERT( result )
