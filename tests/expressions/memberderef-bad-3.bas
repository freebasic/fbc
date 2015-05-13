' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

dim x as UDT = (123)
dim p as UDT ptr = @x
dim pp as UDT ptr ptr = @p

print p[0]->i
