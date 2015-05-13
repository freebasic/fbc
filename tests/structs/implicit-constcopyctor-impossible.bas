' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	i as integer
	declare constructor( byval as integer )
end type

type Child extends Parent
	s as string
	declare constructor( )
end type
