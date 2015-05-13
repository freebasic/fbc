' TEST_MODE : COMPILE_ONLY_FAIL

declare sub f overload( as uinteger )
declare sub f overload( as ulongint )
f( type( 0 ) )
