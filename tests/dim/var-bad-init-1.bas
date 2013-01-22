' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer
	static s as string
end type
var UDT.s = "foo"
