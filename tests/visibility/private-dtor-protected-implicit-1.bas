' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	declare destructor( )
end type

destructor Parent( )
end destructor

type Child extends Parent
end type
