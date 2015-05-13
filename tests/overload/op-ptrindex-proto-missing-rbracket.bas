' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare operator [( index as integer ) as integer
end type

operator UDT.[]( index as integer ) as integer
	operator = 0
end operator
