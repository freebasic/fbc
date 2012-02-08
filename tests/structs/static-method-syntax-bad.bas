' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer dummy
	declare sub normal()
end type

static sub T.normal()
end sub
