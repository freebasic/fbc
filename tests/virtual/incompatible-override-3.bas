' TEST_MODE : COMPILE_ONLY_FAIL

type UDT
	'' huge UDT that will be returned on stack
	as integer a, b, c, d, e, f, g, h
end type

type A extends object
	declare virtual function foo( ) as UDT
end type

type B extends A
	declare function foo( ) as integer
end type
