' TEST_MODE : COMPILE_AND_RUN_OK

#define ASSERT(e) if (e) = 0 then fb_Assert(__FILE__, __LINE__, __FUNCTION__, #e)

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

assert( (i & d) = "11" )


i  = -1
s  = -1
d  = -1
l  = -1

assert( str$(i)  = "-1" )
assert( str$(s)  = "-1" )
assert( str$(d)  = "-1" )
assert( str$(l)  = "-1" )

assert( (i & d) = "-1-1")


assert( str$(1%)    = " 1" )
assert( str$(1!)   = " 1" )
assert( str$(1#)   = " 1" )
assert( str$(1&)  = " 1" )

assert( ( 1% &  1#) = "11")

assert( str$(-1%)    = "-1" )
assert( str$(-1!)   = "-1" )
assert( str$(-1#)   = "-1" )
assert( str$(-1&)  = "-1" )

assert( (-1% & -1#) = "-1-1")


dim as __ulong ul

ul = &h80000000u

assert( str$(ul) = " 2147483648" )

assert( str$(&h80000000u) = " 2147483648" )


dim as __longint ll
dim as __ulongint ull

ll  = &h7fffffffffffffffll
ull = &h7fffffffffffffffull

assert( str$(ll)   = " 9223372036854775807" )
assert( str$(ull)  = " 9223372036854775807" )

assert( str$(&h7fffffffffffffffll)   = " 9223372036854775807" )
assert( str$(&h7fffffffffffffffull)  = " 9223372036854775807" )


ll  = &h8000000000000000ll
ull = &h8000000000000000ull

assert( str$(ll)   = "-9223372036854775808" )
assert( str$(ull)  = " 9223372036854775808" )

assert( str$(&h8000000000000000ll)   = "-9223372036854775808" )
assert( str$(&h8000000000000000ull)  = " 9223372036854775808" )


