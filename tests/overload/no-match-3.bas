' TEST_MODE : COMPILE_ONLY_FAIL

declare sub f overload( byval as integer )
declare sub f overload( byval as uinteger )
declare sub f overload( byval as long )
declare sub f overload( byval as ulong )
declare sub f overload( byval as longint )
declare sub f overload( byval as ulongint )

dim as integer ptr p
f( p )
