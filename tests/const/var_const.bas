' TEST_MODE : COMPILE_ONLY_FAIL

type T : n as const integer = 69 : end type
dim x as T
var p = @(x.n)
*p = 0
