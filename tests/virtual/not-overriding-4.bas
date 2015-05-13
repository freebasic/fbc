' TEST_MODE : COMPILE_ONLY_FAIL

type UDT1
	a as integer
end type

type UDT2
	a(0 to 9) as double
	b as integer
	c as longint
end type

type A extends object
	declare virtual function f( ) as UDT1
end type

type B extends A
	'' should not override because the return type is different
	'' (they're both UDTs, but different UDTs, it's not safe,
	'' eg. one could be returned on stack, the other in regs, ...)
	declare function f( ) as UDT2 override
end type
