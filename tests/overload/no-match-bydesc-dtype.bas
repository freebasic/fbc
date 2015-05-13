' TEST_MODE : COMPILE_ONLY_FAIL

declare sub f overload( a(any) as integer )
declare sub f overload( a(any) as single )

dim array(any) as string
f( array() )
