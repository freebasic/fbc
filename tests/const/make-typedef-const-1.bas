' TEST_MODE : COMPILE_ONLY_FAIL

type t as integer ptr
dim as const t p = 0

'' It's an INTEGER CONST PTR, not an CONST INTEGER PTR
p = 0   '' error
