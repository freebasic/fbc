' TEST_MODE : COMPILE_ONLY_FAIL

union UDT
	a as integer
	b as integer
end union

dim x as UDT
dim as integer a, b

let( a, b ) = x
