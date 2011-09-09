' TEST_MODE : COMPILE_ONLY_FAIL

type t as const u
type u as integer ptr
dim as t i = 0
i = 0       '' error
