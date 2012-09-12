' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
end type

dim p as UDT ptr
p->destructor( )
