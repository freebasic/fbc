' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	declare constructor( byval as integer )
end type

constructor T( byval i as integer )
end constructor

redim as T x(0 to 0)
