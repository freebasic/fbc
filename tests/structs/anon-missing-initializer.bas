' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	j as integer
end type

'' Regression test: The missing initializer values shouldn't cause a compiler crash
print type<UDT>().i, type<UDT>().j
