' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	union
		a as integer
		b as integer
	end union
end type

dim x as UDT
dim as integer a, b

let( a, b ) = x
