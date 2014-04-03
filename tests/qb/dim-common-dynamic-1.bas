' TEST_MODE : COMPILE_ONLY_OK

#lang "qb"

'' DIM'ing a COMMON works like a REDIM
common array() as integer
dim array(1 to 2) as integer
