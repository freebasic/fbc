' TEST_MODE : COMPILE_AND_RUN_OK

#lang "qb"

declare sub s()

dim shared a%
a% = 1

__assert(a% = 1)
s()
__assert(a% = 1)

sub s()
	dim a%
	__assert(a% = 0)
	a% = 2
	__assert(a% = 2)
end sub
