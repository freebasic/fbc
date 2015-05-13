' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

dim shared a
#assert __typeof( a ) = __typeof( single )
