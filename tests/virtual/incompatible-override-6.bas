' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual destructor cdecl( )
end type

type B extends A
	declare destructor stdcall( )
end type
