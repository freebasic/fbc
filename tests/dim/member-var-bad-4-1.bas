' TEST_MODE : COMPILE_ONLY_FAIL

'' Normal POD UDT
type UDT
	i as integer
end type

'' UDT.i is a field, not a member var
dim UDT.i as integer
