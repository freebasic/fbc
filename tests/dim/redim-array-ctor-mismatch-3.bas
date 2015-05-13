' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	declare constructor stdcall( )
end type

constructor T stdcall( )
end constructor

redim as T x(0 to 0)
