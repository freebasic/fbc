' TEST_MODE : COMPILE_ONLY_FAIL
#lang "qb"

'' suffixtype + astype aren't allowed to be used together currently, even if
'' the type matches
redim array$(0 to 1) as string
