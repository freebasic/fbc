' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	foo as integer
	static i() as integer
end type

redim UDT.i() as integer
redim UDT.i() as integer
