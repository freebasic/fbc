' TEST_MODE : COMPILE_ONLY_OK
#lang "qb"

'' No 'AS DataType', no suffix, no DEF*: Should use the default type
redim array(0 to 1)
#assert __typeof( array ) = __typeof( single )
