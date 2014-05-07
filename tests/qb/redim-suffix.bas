' TEST_MODE : COMPILE_AND_RUN_OK

#lang "qb"

#define assert(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

'' string vs. integer

dim a() as string
redim a$(1 to 1)
assert( lbound( a ) = 1 )
assert( ubound( a ) = 1 )
assert( lbound( a$ ) = 1 )
assert( ubound( a$ ) = 1 )

dim b() as string
dim b%
redim b$(1 to 1)
assert( lbound( b ) = 1 )
assert( ubound( b ) = 1 )
assert( lbound( b$ ) = 1 )
assert( ubound( b$ ) = 1 )

dim c%
dim c() as string
redim c$(1 to 1)
assert( lbound( c ) = 1 )
assert( ubound( c ) = 1 )
assert( lbound( c$ ) = 1 )
assert( ubound( c$ ) = 1 )

dim d() as string
redim d(1 to 1)
redim d%(2 to 2)  '' not an error, just a new array
assert( lbound( d ) = 1 )
assert( ubound( d ) = 1 )
assert( lbound( d$ ) = 1 )
assert( ubound( d$ ) = 1 )
assert( lbound( d% ) = 2 )
assert( ubound( d% ) = 2 )

'' integer vs. string

dim e() as integer
redim e%(1 to 1)
assert( lbound( e ) = 1 )
assert( ubound( e ) = 1 )
assert( lbound( e% ) = 1 )
assert( ubound( e% ) = 1 )

dim f() as integer
dim f$
redim f%(1 to 1)
assert( lbound( f ) = 1 )
assert( ubound( f ) = 1 )
assert( lbound( f% ) = 1 )
assert( ubound( f% ) = 1 )

dim g$
dim g() as integer
redim g%(1 to 1)
assert( lbound( g ) = 1 )
assert( ubound( g ) = 1 )
assert( lbound( g% ) = 1 )
assert( ubound( g% ) = 1 )

dim h() as integer
redim h(1 to 1)
redim h$(2 to 2)  '' not an error, just a new array
assert( lbound( h ) = 1 )
assert( ubound( h ) = 1 )
assert( lbound( h% ) = 1 )
assert( ubound( h% ) = 1 )
assert( lbound( h$ ) = 2 )
assert( ubound( h$ ) = 2 )
