' TEST_MODE : COMPILE_ONLY_FAIL

union UDT
	a as integer
	type
		b as integer
		c as integer
	end type
end union

dim as UDT x = ( 1, ( 2 ) )
