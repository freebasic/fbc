' TEST_MODE : COMPILE_ONLY_FAIL

type A1
	i as integer
end type
type A2 extends A1
	j as integer
end type

type B1 extends object
	declare virtual sub f( byval as A2 )
end type
type B2 extends B1
	declare sub f( byval as A1 ) override
end type
