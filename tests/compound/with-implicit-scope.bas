' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

dim x as UDT

with x
	dim insideonly as integer
end with

print insideonly
