' TEST_MODE : COMPILE_AND_RUN_OK

#lang "fblite"

'' same as -lang qb

dim as integer i, j, iend = 10, jend = 20

for i = 1 to iend
	goto goaway
	comeback:
next i
assert(i = iend+1)


goto fin

goaway:
for j = 1 to jend
next j
goto comeback

fin:
