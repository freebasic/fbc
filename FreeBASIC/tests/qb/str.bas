' TEST_MODE : COMPILE_AND_RUN_OK

dim as integer i
dim as uinteger ui

dim as single s
dim as double d

dim as longint l
dim as ulongint ul

i  = 1
ui = 1
s  = 1
d  = 1
l  = 1
ul = 1

assert( str(i)  = " 1" )
assert( str(ui) = " 1" )
assert( str(s)  = " 1" )
assert( str(d)  = " 1" )
assert( str(l)  = " 1" )
assert( str(ul) = " 1" )

i  = -1
s  = -1
d  = -1
l  = -1

assert( str(i)  = "-1" )
assert( str(s)  = "-1" )
assert( str(d)  = "-1" )
assert( str(l)  = "-1" )

