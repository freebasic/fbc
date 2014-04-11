' TEST_MODE : COMPILE_ONLY_FAIL

declare sub f overload( a(any) as integer )
declare sub f overload( a(any, any) as integer )

dim array3(any, any, any) as integer
f( array3() )
