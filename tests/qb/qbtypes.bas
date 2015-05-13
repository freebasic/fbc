' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

assert( len(int1%) = 2 )
assert( len(lng1&) = 4 )
assert( len(sng1!) = 4 )
assert( len(dbl1#) = 8 )

dim int2 as integer, lng2 as long, sng2 as single, dbl2 as double

assert( len(int2) = 2 )
assert( len(lng2) = 4 )
assert( len(sng2) = 4 )
assert( len(dbl2) = 8 )

assert( len(cint(0)) = 2 )
assert( len(clng(0)) = 4 )
assert( len(csng(0)) = 4 )
assert( len(cdbl(0)) = 8 )
