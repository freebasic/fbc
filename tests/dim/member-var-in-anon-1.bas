' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	union
		i as integer
		static x as integer
	end union
end type
