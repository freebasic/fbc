' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	private:
	declare destructor( )
end type

destructor T( )
end destructor

type Foo
	as T x
end type
