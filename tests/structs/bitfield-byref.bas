' TEST_MODE : COMPILE_ONLY_FAIL

type T
	n:1 as integer
end type

dim x as T
dim byref y as integer = x.n
