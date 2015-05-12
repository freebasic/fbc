' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
end type

dim as T x
dim as const integer i = 0
let(i) = x
