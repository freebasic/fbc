' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

common a
#assert __typeof( a ) = __typeof( single )
