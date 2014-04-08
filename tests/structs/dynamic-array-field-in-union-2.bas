' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	union
		type
			array(any) as integer
		end type
	end union
end type
