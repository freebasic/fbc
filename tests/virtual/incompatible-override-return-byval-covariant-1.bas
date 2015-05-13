' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual function f( ) as A
end type

type B extends A
	declare function f( ) as B override
end type
