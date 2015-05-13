' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer i
end type

dim as integer ptr i = @(cast(T ptr, 123)->i)
print i
