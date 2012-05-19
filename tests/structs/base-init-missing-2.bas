' TEST_MODE : COMPILE_ONLY_FAIL

type Parent
	as integer i
	declare constructor( byval as integer )
end type

constructor Parent( byval i as integer )
	this.i = i
end constructor

type Child extends Parent
	declare constructor( )
	declare constructor( byref as Child )
end type

constructor Child( )
	base( 123 )
end constructor

constructor Child( byref rhs as Child )
	'' The base UDT only has a non-default constructor -- the compiler must
	'' show an error if BASE() wasn't used.
end constructor

dim as Child x
