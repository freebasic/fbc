' TEST_MODE : COMPILE_ONLY_FAIL

type T
	__ as integer
	declare operator new( byval size as uinteger ) as any ptr
	declare static operator new( byval size as uinteger ) as any ptr	
end type
