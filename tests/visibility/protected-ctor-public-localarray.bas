' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare constructor( )
end type

constructor T( )
end constructor

dim as T x(0 to 1)
