' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual sub foo( )
end type

type B extends A
	declare function foo( ) as integer
end type
