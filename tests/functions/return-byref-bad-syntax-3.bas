' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	dummy as integer
	declare property f( as integer ) byref
end type
