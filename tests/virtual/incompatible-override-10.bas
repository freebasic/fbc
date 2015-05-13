' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual sub f( byval i as integer )
end type

type B extends A
	declare sub f( byref i as integer )
end type
