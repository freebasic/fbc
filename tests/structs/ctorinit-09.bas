' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer a, b, c
	declare constructor( )
end type

constructor Parent( )
end constructor

type Child extends Parent
	declare constructor( )
end type

constructor Child( )
	'' Constructor must be called, cannot initialize directly
	base( 1, 2, 3 )
end constructor

dim as Child x
