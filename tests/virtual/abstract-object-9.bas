' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare abstract sub f1( )
end type

declare function foo( ) as A
