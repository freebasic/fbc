' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

#define assert(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

'' deftype for 'a' is SINGLE, but since it's a REDIM of an existing array,
'' here it should re-use the existing array's dtype.
redim a(1 to 1) as string
redim a(2 to 2)
#assert __typeof( a ) = __typeof( string )

assert( lbound( a ) = 2 )
assert( ubound( a ) = 2 )

assert( lbound( a$ ) = 2 )
assert( ubound( a$ ) = 2 )
