' TEST_MODE : COMPILE_ONLY_FAIL

union UDT
	type
		a as integer
	end type
end union

dim as UDT x = ( 1, 2 )
