' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	as integer a
	declare constructor( )
end type

constructor UDT( )
end constructor

goto foo

dim as UDT x = UDT( )

foo:
