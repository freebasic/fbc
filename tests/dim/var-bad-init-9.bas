' TEST_MODE : COMPILE_ONLY_FAIL

type A
	as integer x, y, z
end type

type B
	as integer x, y, z
end type

type UDT
	dummy as integer

	static x as A
end type

var UDT.x = type<B>( 1, 2, 3 )
