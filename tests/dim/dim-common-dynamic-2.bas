' TEST_MODE : COMPILE_ONLY_OK

var l = 1
var u = 2

'' DIM'ing a COMMON works like a REDIM
common array() as integer
dim array(l to u) as integer
