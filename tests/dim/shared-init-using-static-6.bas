' TEST_MODE : COMPILE_ONLY_FAIL

static as integer i

type UDT
	__ as integer
	static pi as integer ptr
end type

dim UDT.pi as integer ptr = @i
