' TEST_MODE : COMPILE_ONLY_FAIL

#include once "fbgfx.bi"

dim p as fb.IMAGE ptr
line *p, (0, 0) - (31, 31), rgb(0,0,0)
