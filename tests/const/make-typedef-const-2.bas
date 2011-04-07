' TEST_MODE : COMPILE_ONLY_OK

type t as integer ptr
dim as const t p = 0

'' It's a INTEGER CONST PTR, not an CONST INTEGER PTR
*p = 0  '' ok
