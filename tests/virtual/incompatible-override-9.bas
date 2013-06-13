' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual function f( ) as integer
end type

type B extends A
	declare function f( ) byref as integer
end type
