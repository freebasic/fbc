' TEST_MODE : COMPILE_ONLY_FAIL

declare sub f overload( byval as integer ptr ptr )
declare sub f overload( byval as integer ptr ptr ptr )

dim as integer ptr p
f( p )
