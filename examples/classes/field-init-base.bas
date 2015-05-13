
type TBase
	dim baseField as integer = 1234
	
	declare constructor()
	declare constructor(value as integer)
end type

constructor Tbase()
end constructor

constructor TBase(value as integer)
	baseField = value
end constructor

type TFoo extends TBase
	dim fooField as integer = 5678

	declare constructor()
	declare constructor(value as integer)
	declare constructor(baseValue as integer, value as integer)
end type

constructor TFoo()
end constructor

constructor TFoo(value as integer)
	fooField = value
end constructor

constructor TFoo(baseValue as integer, value as integer)
	base( baseValue )
	fooField = value
end constructor

sub main
	dim f1 as TFoo
	assert( f1.baseField = 1234 )
	assert( f1.fooField = 5678 )

	dim f2 as TFoo = (-3456)
	assert( f2.baseField = 1234 )
	assert( f2.fooField = -3456 )

	dim f3 as TFoo = TFoo(3333, 4444)
	assert( f3.baseField = 3333 )
	assert( f3.fooField = 4444 )
	
	print "all tests ok"
end sub

	main
	
	