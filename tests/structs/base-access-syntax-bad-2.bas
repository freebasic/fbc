' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	i1 as integer
end type

type B extends A
	declare sub f()
end type

sub B.f()
	print base
	i1
end sub
