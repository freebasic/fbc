' TEST_MODE : COMPILE_ONLY_FAIL

declare sub f overload( byval as byte ptr )
declare sub f overload( byval as short ptr )

dim as any ptr p
f( p )
