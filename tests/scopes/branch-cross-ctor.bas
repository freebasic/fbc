' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	as integer a
	'' non-default ctor
	declare constructor( byval i as integer )
end type

constructor UDT( byval i as integer )
end constructor

goto foo

dim as UDT x = UDT( 1 )

foo:
