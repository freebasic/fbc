' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual sub f( byval as A )
end type

type B extends A
	declare sub f( byval as B ) override
end type
