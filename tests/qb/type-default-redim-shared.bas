' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

redim shared array(0 to 1)
#assert __typeof( array ) = __typeof( single )
