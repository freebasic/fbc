' TEST_MODE : COMPILE_ONLY_FAIL

declare sub f( array(any, any) as integer )
declare sub f( array(any) as single )

dim array() as single
f( array() )
redim array(0 to 0, 0 to 0)
