' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	private:
	declare constructor( )
end type

constructor Parent( )
end constructor

type Child extends Parent
	declare constructor( byref as Child )
end type

constructor Child( byref rhs as Child )
end constructor
