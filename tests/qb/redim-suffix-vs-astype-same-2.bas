' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

#define assert(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

redim a(1 to 1) as string
redim a$(2 to 2)

assert( lbound( a ) = 2 )
assert( ubound( a ) = 2 )

assert( lbound( a$ ) = 2 )
assert( ubound( a$ ) = 2 )
