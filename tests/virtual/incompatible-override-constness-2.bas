' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	dummy as integer
	declare virtual function f( ) as integer
end type

type B extends A
	declare function f( ) as const integer override
end type
