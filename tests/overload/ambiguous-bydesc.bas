' TEST_MODE : COMPILE_ONLY_FAIL

declare sub f overload( array(any) as integer )
declare sub f overload( array(any, any) as integer )

dim array() as integer
f( array() )
