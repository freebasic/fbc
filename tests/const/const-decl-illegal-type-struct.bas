' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer
end type
const x as UDT = type<UDT>(0)
