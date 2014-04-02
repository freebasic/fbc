' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	array(0 to 1) as integer
end type

dim x as UDT
with x
	redim .array(1 to 2)
end with
