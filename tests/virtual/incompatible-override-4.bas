' TEST_MODE : COMPILE_ONLY_FAIL

type A extends object
	declare virtual sub foo stdcall( )
end type

type B extends A
	declare sub foo cdecl( )
end type
