' TEST_MODE : COMPILE_ONLY_FAIL

dim as const zstring ptr pcz
dim as zstring ptr pz
dim as integer cond

pz = iif( cond, pcz, pz )
