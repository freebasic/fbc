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
end type

constructor Child( )
	print "foo"
	base( 5 )
end constructor

dim as Child x
