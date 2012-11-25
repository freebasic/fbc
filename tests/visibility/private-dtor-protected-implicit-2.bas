' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	declare destructor( )
end type

type Child extends Parent
	declare destructor( )
end type

destructor Child( )
end destructor
