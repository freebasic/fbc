' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer a, b, c
end type

type Child extends Parent
	declare constructor( )
end type

constructor Child( )
	base( 1, 2, 3, 4 )
end constructor

dim as Child x
