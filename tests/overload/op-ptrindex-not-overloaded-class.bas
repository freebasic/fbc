' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare constructor( )
end type

constructor UDT( )
end constructor

dim x as UDT
print x[0]
