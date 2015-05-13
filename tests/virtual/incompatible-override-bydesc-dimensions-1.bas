' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual sub f( () as integer )
end type

type B extends A
	declare sub f( (any) as integer ) override
end type
