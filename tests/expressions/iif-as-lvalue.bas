' TEST_MODE : COMPILE_ONLY_FAIL

'' This could be treated as an assignment to the iif() temp var,
'' but that'd be useless, so it's better to disallow it, like assignments to
'' CALLs or BOPs etc.
dim as integer cond
iif( cond, 0, 0 ) = 0
