' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

'' Not a typeless REDIM, because it has the default dtype
defint a-z
redim array(0 to 1)
