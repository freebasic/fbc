' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer dummy
	declare const sub const1()
	declare const sub const2()
end type

sub T.const1()
end sub

const sub T.const2()
end sub
