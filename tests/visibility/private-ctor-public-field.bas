' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	private:
	declare constructor( )
end type

constructor T( )
end constructor

type Foo
	as T x
end type
