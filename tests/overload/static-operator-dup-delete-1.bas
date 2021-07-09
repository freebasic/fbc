' TEST_MODE : COMPILE_ONLY_FAIL

type T
	__ as integer
	declare operator delete( byval p as any ptr )
	declare static operator delete( byval p as any ptr )	
end type
