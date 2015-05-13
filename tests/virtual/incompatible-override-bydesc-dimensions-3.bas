' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual sub f( (any) as integer )
end type

type B extends A
	declare sub f( (any, any) as integer ) override
end type
