' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

#define assert(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

defstr a

'' 1 array since deftype for "a" is STRING, allowing the 2nd redim to be a
'' REDIM of an existing array.
redim a(1 to 1) as string
redim a(2 to 2)
#assert __typeof( a ) = __typeof( string )

assert( lbound( a ) = 2 )
assert( ubound( a ) = 2 )

assert( lbound( a$ ) = 2 )
assert( ubound( a$ ) = 2 )
