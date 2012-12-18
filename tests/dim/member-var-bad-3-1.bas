' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer
end type

'' UDT.i was not declared
dim UDT.i as integer
