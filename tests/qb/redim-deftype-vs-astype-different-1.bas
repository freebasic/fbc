' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

#define assert(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

'' 2 arrays: 1st SINGLE, 2nd STRING
redim a(1 to 1)
#assert __typeof( a ) = __typeof( single )
redim a(2 to 2) as string

assert( lbound( a ) = 2 )
assert( ubound( a ) = 2 )

assert( lbound( a! ) = 1 )
assert( ubound( a! ) = 1 )

assert( lbound( a$ ) = 2 )
assert( ubound( a$ ) = 2 )
