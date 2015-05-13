' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual destructor pascal( )
end type

type B extends A
end type
