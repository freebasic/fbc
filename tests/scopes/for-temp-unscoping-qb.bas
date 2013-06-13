' TEST_MODE : COMPILE_AND_RUN_OK

#lang "qb"

iend = 10
jend = 20

'' The temp var(s) used by the FOR loops should be unscoped in -lang qb/fblite,
'' like any other var, as if there were no implicit scopes, allowing for GOTOs
'' in and out.
for i = 1 to iend
	goto goaway
	comeback:
next i
__assert(i = iend+1)


goto fin

goaway:
for j = 1 to jend
next j
goto comeback

fin:
