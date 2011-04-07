' TEST_MODE : COMPILE_ONLY_FAIL

type t as const u ptr
type u as integer
dim as t p
*p = 0      '' error
