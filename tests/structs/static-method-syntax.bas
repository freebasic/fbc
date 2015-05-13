' TEST_MODE : COMPILE_ONLY_OK

type T
	as integer dummy
	declare static sub static1()
	declare static sub static2()
end type

sub T.static1()
end sub

static sub T.static2()
end sub
