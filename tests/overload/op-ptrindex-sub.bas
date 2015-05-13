' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare operator []( index as integer )
end type

operator UDT.[]( index as integer )
end operator
