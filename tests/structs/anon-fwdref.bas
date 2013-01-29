' TEST_MODE : COMPILE_ONLY_FAIL

type typedef as forward
declare sub f( byref x as typedef )
f( type( 0 ) )
