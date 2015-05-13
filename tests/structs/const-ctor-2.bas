' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	i as integer
	declare const constructor()
end type

const constructor UDT()
end constructor
