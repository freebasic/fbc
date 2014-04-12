' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

dim a
#assert __typeof( a ) = __typeof( single )
