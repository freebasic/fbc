' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	dummy as integer
	declare virtual sub f( )
end type

type B extends A
	declare const sub f( ) override
end type
