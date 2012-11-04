' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	declare destructor stdcall( )
end type

destructor T stdcall( )
end destructor

dim as T x(0 to 0)
erase x
