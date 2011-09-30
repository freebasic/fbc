' TEST_MODE : COMPILE_ONLY_OK
		
sub f( byref d as const integer )
	dim as integer h = d
end sub

type vec
	as integer x, y, z
end type

dim as integer x, y, z
dim as const integer fd = 0
x = fd
dim as const vec foo = (1, 2, 3)
dim as vec kj
kj = foo
x = foo.x

let( x, y, z ) = foo
