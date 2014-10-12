' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare sub aaa()
end type

declare sub UDT.bbb()
