' TEST_MODE : COMPILE_ONLY_FAIL

declare sub f( byref x as any )
f( type( 0 ) )
