' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer
	declare operator let( byref rhs as UDT ) byref
end type
