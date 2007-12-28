' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = FALSE then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

dim as integer i
dim as long l

dim as single s
dim as double d


i  = 1
s  = 1
d  = 1
l  = 1

assert( str$(i)  = " 1" )
assert( str$(s)  = " 1" )
assert( str$(d)  = " 1" )
assert( str$(l)  = " 1" )

i  = -1
s  = -1
d  = -1
l  = -1

assert( str$(i)  = "-1" )
assert( str$(s)  = "-1" )
assert( str$(d)  = "-1" )
assert( str$(l)  = "-1" )

assert( str$(1%)    = " 1" )
assert( str$(1!)   = " 1" )
assert( str$(1#)   = " 1" )
assert( str$(1&)  = " 1" )

assert( str$(-1%)    = "-1" )
assert( str$(-1!)   = "-1" )
assert( str$(-1#)   = "-1" )
assert( str$(-1&)  = "-1" )

