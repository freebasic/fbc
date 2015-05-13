' TEST_MODE : COMPILE_ONLY_FAIL

#include once "fbgfx.bi"

dim p as const FB.IMAGE ptr = imagecreate( 32, 32 )
line p, (0, 0) - (31, 31), rgb(0,0,0)
