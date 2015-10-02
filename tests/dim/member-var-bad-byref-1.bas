' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer

	static byref ri as integer
end type

dim shared i as integer

dim shared UDT.ri as integer = i
