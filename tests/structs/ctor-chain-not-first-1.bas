' TEST_MODE : COMPILE_ONLY_FAIL

type T
	as integer i
	declare constructor( )
	declare constructor( byval as integer )
end type

constructor T( )
	print "foo"
	constructor( 5 )
end constructor

constructor T( byval i as integer )
	this.i = i
end constructor

dim as T x
