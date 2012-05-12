' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	protected:
	declare constructor( )
end type

constructor T( )
end constructor

var p = new T( )
